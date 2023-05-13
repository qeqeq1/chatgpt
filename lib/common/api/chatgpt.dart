import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPT {
  final String _apiUrl = 'https://gpt-api.01r.cc';
  String key;

  ChatGPT(this.key);

  ///{"id":"chatcmpl-7FeRxBy88jExoGr6M0DzxlSjCyu9Y",
  ///"object":"chat.completion",
  ///"created":1683964765,
  ///"model":"gpt-3.5-turbo-0301",
  ///"usage":{"prompt_tokens":10,"completion_tokens":16,"total_tokens":26},
  ///"choices":[{"message":{"role":"assistant","content":"您好！有什么能为您效劳吗？"},
  ///"finish_reason":"stop","index":0}]}
  Future<String> chat(String content) async {
    if (key.isEmpty) {
      return 'url';
    }
    Uri url = Uri.parse('$_apiUrl/v1/chat/completions');
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
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Map result = jsonDecode(utf8.decode(response.bodyBytes));
        return result['choices'][0]['message']['content'];
      }
    } catch (e) {
      return '异常: $e';
    }
    return '';
  }
}
