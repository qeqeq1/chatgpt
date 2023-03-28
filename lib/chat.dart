import 'package:chatgpt/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bubble.dart';
import 'chatgpt.dart';
import 'config.dart';

ScrollController scrollController = ScrollController();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  bool showToBottom = false;

  @override
  initState() {
    super.initState();
    load().then((_) async {
      await chatgpt('你好');
    });
    scrollController.addListener(() {
      if (scrollController.offset < scrollController.position.maxScrollExtent) {
        setState(() {});
        showToBottom = true;
      } else {
        setState(() {});
        showToBottom = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void send(String content) {
    if (messages.isNotEmpty) {
      Bubble last = messages[messages.length - 1];
      if (last.text == '') {
        messages.removeLast();
      }
    }
    if (controller.text.isNotEmpty) {
      Bubble message = Bubble(content, isLeft: false);
      messages.add(message);
    }
    chatgpt(content);
    controller.clear();
    Future.delayed(Duration(milliseconds: 500), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    setState(() {});
  }

  chatgpt(String content) async {
    String _content = '';
    if (content.length >= 2 &&
        content.substring(content.length - 2, content.length) == '继续') {
      for (int i = 2; i < messages.length; i++) {
        _content = _content + '\r\n' + messages[i].text;
      }
      content = _content;
    }
    Bubble message = Bubble('');
    messages.add(message);
    chat(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(68, 70, 84, 1),
          title: Obx(() => Text('${statusCode.value}',
              style: TextStyle(
                  color: statusCode.value == 200
                      ? Color.fromARGB(255, 0, 255, 8)
                      : Color.fromARGB(255, 255, 17, 0),
                  fontSize: 25))),
          actions: [
            GestureDetector(
              onTap: () {
                messages.clear();
                chatgpt('你好');
              },
              child: Icon(Icons.refresh, size: 40, color: Colors.white),
            ),
            GestureDetector(
                onTap: () {
                  Get.to(SettingPage());
                },
                child: Icon(Icons.settings, color: Colors.white, size: 40)),
            Padding(padding: EdgeInsets.only(right: 5))
          ],
        ),
        body: Stack(children: [
          Container(
            color: Color.fromRGBO(52, 53, 65, 1),
          ),
          Column(children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    controller: scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => messages[index],
                    itemCount: messages.length,
                  )),
            ),
            Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                height: 50,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 65, 79, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                                size: 25,
                              ),
                              onPressed: () {
                                send(controller.text);
                              },
                              color: Colors.white)),
                      scrollPadding: EdgeInsets.all(0),
                      onSubmitted: (input) {
                        send(controller.text);
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ))
          ]),
          Positioned(
              bottom: 75,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                child: ClipOval(
                  child: Container(
                    color: showToBottom ? Colors.grey : Colors.transparent,
                    child: Icon(
                      Icons.file_download,
                      size: 30,
                      color: showToBottom ? Colors.white : Colors.transparent,
                    ),
                  ),
                ),
              )),
        ]));
  }
}
