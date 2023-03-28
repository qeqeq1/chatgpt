import 'dart:convert';
import 'package:http/http.dart' as http;

import 'bubble.dart';
import 'chat.dart';
import 'config.dart';

///聊天
chat(String content) async {
  Future.delayed(Duration(milliseconds: 500), () {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  });
  Uri url = Uri.parse('$apiUrl/v1/chat/completions');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $key'
  };
  Object body = jsonEncode({
    'model': 'gpt-3.5-turbo-0301',
    'messages': [
      {'role': 'user', 'content': content}
    ]
  });
  try {
    if (content == 'key') {
      Uri keyUrl = Uri.parse('https://v1.apigpt.cn/key/?key=$key');
      var response = await http.get(keyUrl);

      Map result = jsonDecode(utf8.decode(response.bodyBytes));
      statusCode.value = response.statusCode;
      if (messages.isNotEmpty) {
        messages.removeLast();
      }
      Bubble message = Bubble(
          '总额度:${result['total_granted']},已使用:${result['total_used']},剩余:${result['total_available']}');
      messages.add(message);
      return 'key';
    }
    var response = await http.post(url, headers: headers, body: body);
    statusCode.value = response.statusCode;
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (statusCode.value != 200) {
      if (messages.isNotEmpty) {
        messages.removeLast();
      }
    }
    if (key.isEmpty) {
      Bubble message = Bubble('url');
      messages.add(message);
    } else if (statusCode.value == 401) {
      Bubble message = Bubble('Key错误,请检查');
      messages.add(message);
    }
    if (response.statusCode == 200) {
      Map result = jsonDecode(utf8.decode(response.bodyBytes));
      String content = result['choices'][0]['message']['content'];
      if (messages.isNotEmpty) {
        messages.removeLast();
      }
      Bubble message = Bubble(content);
      messages.add(message);
    }
  } catch (e) {
    print('异常: $e');
    if (messages.isNotEmpty) {
      statusCode.value = 400;
      messages.removeLast();
    }
    String text = '$e';
    if (text == 'Connection timed out') {
      text = '请求超时';
    }
    Bubble message = Bubble(text);
    messages.add(message);
  }
  Future.delayed(Duration(milliseconds: 500), () {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  });
}
