import 'package:chatgpt/common/api/chatgpt.dart';
import 'package:chatgpt/common/models/key_model.dart';
import 'package:chatgpt/common/widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingcontroller = TextEditingController();
  RxBool isAtButton = false.obs;
  List messages = [].obs;
  RxBool loading = false.obs;
  RxKeyModel model = RxKeyModel();

  HomepageController();

  _initData() async {
    update(["homepage"]);
    await model.load();
    // loading.value = true;
    // String result = await ChatGPT(model.key.value).chat('你好');
    // messages.add(Bubble(result.toString(), isLeft: false));
    // loading.value = false;
    // scrollController.addListener(controllerListener);
  }

  void controllerListener() {
    if (scrollController.offset <
        scrollController.position.maxScrollExtent - 20) {
      isAtButton.value = true;
    } else {
      isAtButton.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void jumpToLast() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void clear() {
    messages.clear();
    addMessage(const Bubble('你好'));
  }

  Future<void> addMessage(Bubble message) async {
    loading.value = true;
    await model.load();
    messages.add(message);
    textEditingcontroller.text = '';
    String result = await ChatGPT(model.key.value).chat(message.text);
    messages.add(Bubble(result.toString(), isLeft: false));
    jumpToLast();
    loading.value = false;
  }
}
