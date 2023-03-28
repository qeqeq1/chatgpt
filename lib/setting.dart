import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController keyController = TextEditingController();
  TextEditingController apiController = TextEditingController();
  FocusNode keyFocusNode = FocusNode();
  FocusNode apiFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    keyController.text = key;
    apiController.text = apiUrl;
  }

  @override
  void dispose() {
    super.dispose();
    keyController.dispose();
    apiController.dispose();
  }

  settingTextField(String title, String input, TextEditingController controller,
      FocusNode focusNode, int maxLines, double width) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        '$title:',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      Padding(padding: EdgeInsets.only(left: 10)),
      Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: width,
          decoration: BoxDecoration(
              color: Color.fromRGBO(64, 65, 79, 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              TextField(
                maxLines: maxLines,
                focusNode: focusNode,
                controller: controller,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                scrollPadding: EdgeInsets.all(0),
                onChanged: (value) {
                  // if (value.substring(0, 2) == 'sk') {
                  key = value;
                  // }
                  // if (value.substring(0, 5) == 'https') {
                  //   apiUrl = value;
                  // }
                  save();
                },
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ))
    ]);
  }

  Widget bottomUrl(String title, String web) {
    return GestureDetector(
        onTap: () async {
          final Uri url = Uri.parse(web);
          await launchUrl(url, mode: LaunchMode.externalApplication);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child:
              Text(title, style: TextStyle(color: Colors.blue, fontSize: 15)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(68, 70, 84, 1),
          automaticallyImplyLeading: true),
      body: GestureDetector(
        onTap: () {
          keyFocusNode.unfocus();
          apiFocusNode.unfocus();
        },
        child: Container(
          color: Color.fromRGBO(52, 53, 65, 1),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              settingTextField(
                  'Key',
                  key,
                  keyController,
                  keyFocusNode,
                  key.length == 0
                      ? 1
                      : MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 1,
                  key.length == 0
                      ? 200
                      : key.length *
                          25 /
                          (MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 4.2
                              : 2.25)),
              // Padding(padding: EdgeInsets.only(top: 10)),
              // settingTextField('API', apiUrl, apiController, apiFocusNode, 1,
              //     apiUrl.length * 10),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  padding: EdgeInsets.all(10),
                  width: 400,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(64, 65, 79, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                      '使用提示: \r\n1.发送key可查询余额\r\n2.最后两个字为继续时才会联系上下文,但请注意token消耗\r\n3.双击击对话可直接复制内容,如有代码框优先复制代码',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
              Flexible(child: Container()),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                bottomUrl('OpenAI', 'https://openai.com'),
                bottomUrl('Flutter', 'https://flutter.cn'),
                bottomUrl('Github', 'https://github.com/autumn-moon-py/chatgpt')
              ]),
              Padding(padding: EdgeInsets.only(bottom: 10))
            ],
          ),
        ),
      ),
    );
  }
}
