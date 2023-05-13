import 'package:chatgpt/pages/Setting/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({super.key});
  final SettingController settingController = Get.put(SettingController());

  Widget settingTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Key:',
          style: TextStyle(color: Colors.white, fontSize: 25.sp),
        ),
        Padding(padding: EdgeInsets.only(left: 10.w)),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            color: const Color.fromRGBO(64, 65, 79, 1),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: 35,
                  maxWidth: MediaQuery.of(context).size.width - 100.w),
              child: TextField(
                controller: settingController.keyController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: -18.h),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                scrollPadding: const EdgeInsets.all(0),
                onChanged: (key) {
                  settingController.setKey(key);
                },
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
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
              Padding(padding: EdgeInsets.only(top: 10.h)),
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
