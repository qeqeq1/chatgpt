import 'package:chatgpt/pages/Setting/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({super.key});
  final SettingController settingController = Get.put(SettingController());

  Widget settingTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Key:',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            color: const Color.fromRGBO(64, 65, 79, 1),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 100),
              child: TextField(
                controller: settingController.keyController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                scrollPadding: const EdgeInsets.all(0),
                onChanged: (key) {
                  settingController.setKey(key);
                },
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '设置',
        ),
      ),
      body: Stack(
        children: [
          Container(color: const Color.fromRGBO(52, 53, 65, 1)),
          Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              settingTextField(context),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      id: "setting",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
