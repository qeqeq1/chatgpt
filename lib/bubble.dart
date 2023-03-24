import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class Bubble extends StatelessWidget {
  Bubble(this.text, {this.isLeft = true});
  final String text;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    if (text == '') {
      return LinearProgressIndicator();
    } else if (text == 'url') {
      return Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        color: Color.fromRGBO(68, 70, 84, 1),
        child: GestureDetector(
            onTap: () async {
              final Uri url =
                  Uri.parse('https://platform.openai.com/account/api-keys');
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('Key为空,点击前往申请Key',
                  style: TextStyle(color: Colors.blue, fontSize: 20)),
            )),
      );
    } else {
      return Container(
          color: isLeft
              ? Color.fromRGBO(68, 70, 84, 1)
              : Color.fromRGBO(52, 53, 65, 1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onDoubleTap: () {
                if (text.contains('```')) {
                  int start = text.indexOf('```') + 3;
                  int last = text.lastIndexOf('```');
                  if (start != -1 && last != -1) {
                    String code = text.substring(start, last);
                    int first = code.indexOf("""

""");
                    code = code.substring(first);
                    Clipboard.setData(ClipboardData(text: code));
                    EasyLoading.showToast('复制成功');
                  }
                } else {
                  Clipboard.setData(ClipboardData(text: text));
                  EasyLoading.showToast('复制成功');
                }
              },
              child: Markdown(
                data: text,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                styleSheet: MarkdownStyleSheet(
                    a: TextStyle(fontSize: 18, color: Colors.white),
                    p: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: text == '请求超时' || text == 'Key错误,请检查'
                            ? Colors.red
                            : Colors.white),
                    h1: TextStyle(color: Colors.white),
                    h2: TextStyle(color: Colors.white),
                    h3: TextStyle(color: Colors.white),
                    h4: TextStyle(color: Colors.white),
                    h5: TextStyle(color: Colors.white),
                    h6: TextStyle(color: Colors.white),
                    em: TextStyle(fontSize: 18, color: Colors.white),
                    strong: TextStyle(fontSize: 18, color: Colors.white),
                    del: TextStyle(fontSize: 18, color: Colors.white),
                    blockquote: TextStyle(fontSize: 18, color: Colors.white),
                    img: TextStyle(fontSize: 18, color: Colors.white),
                    checkbox: TextStyle(fontSize: 18, color: Colors.white),
                    listBullet: TextStyle(fontSize: 18, color: Colors.white),
                    tableHead: TextStyle(fontSize: 18, color: Colors.white),
                    tableBody: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ]));
    }
  }
}
