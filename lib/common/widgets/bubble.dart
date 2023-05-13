import 'package:chatgpt/pages/Setting/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class Bubble extends StatelessWidget {
  const Bubble(this.text, {super.key, this.isLeft = true});

  final String text;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    if (text == 'url') {
      return _buildApiKeysButton();
    } else {
      return _buildMessageBubble();
    }
  }

  Widget _buildApiKeysButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color.fromRGBO(68, 70, 84, 1),
      child: GestureDetector(
        onTap: () async {
          Get.to(() => SettingPage());
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            'Key为空,点击前往设置Key',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble() {
    return GestureDetector(
      onDoubleTap: () {
        Get.to(() => fullScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        color: isLeft
            ? const Color.fromRGBO(52, 53, 65, 1)
            : const Color.fromRGBO(68, 70, 84, 1),
        child: SelectableText(text,
            style: const TextStyle(color: Colors.white, fontSize: 25)),
      ),
    );
  }

  Widget fullScreen() {
    return Scaffold(
        appBar: AppBar(title: const Text('详情')),
        body: Stack(
          children: [
            Container(color: const Color.fromRGBO(52, 53, 65, 1)),
            GestureDetector(
              onDoubleTap: () {
                Clipboard.setData(ClipboardData(text: text));
              },
              child: Markdown(
                data: text,
                physics: const BouncingScrollPhysics(),
                styleSheet: MarkdownStyleSheet(
                  a: const TextStyle(fontSize: 18, color: Colors.white),
                  p: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  h1: const TextStyle(color: Colors.white),
                  h2: const TextStyle(color: Colors.white),
                  h3: const TextStyle(color: Colors.white),
                  h4: const TextStyle(color: Colors.white),
                  h5: const TextStyle(color: Colors.white),
                  h6: const TextStyle(color: Colors.white),
                  em: const TextStyle(fontSize: 18, color: Colors.white),
                  strong: const TextStyle(fontSize: 18, color: Colors.white),
                  del: const TextStyle(fontSize: 18, color: Colors.white),
                  blockquote:
                      const TextStyle(fontSize: 18, color: Colors.white),
                  img: const TextStyle(fontSize: 18, color: Colors.white),
                  checkbox: const TextStyle(fontSize: 18, color: Colors.white),
                  listBullet:
                      const TextStyle(fontSize: 18, color: Colors.white),
                  tableHead: const TextStyle(fontSize: 18, color: Colors.white),
                  tableBody: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
