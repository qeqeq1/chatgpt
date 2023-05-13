import 'package:chatgpt/common/widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Setting/view.dart';
import 'controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomepageViewGetX();
  }
}

class HomepageViewGetX extends GetView<HomepageController> {
  HomepageViewGetX({super.key});
  final HomepageController homepageController = Get.put(HomepageController());

  Widget _buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天'),
        actions: [
          GestureDetector(
            onTap: () {
              homepageController.clear();
            },
            child: const Icon(Icons.refresh),
          ),
          Padding(padding: EdgeInsets.only(right: 5.w)),
          GestureDetector(
            onTap: () => Get.to(() => SettingPage()),
            child: const Icon(Icons.settings),
          ),
          Padding(padding: EdgeInsets.only(right: 5.w)),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Obx(() => homepageController.loading.value
                ? const LinearProgressIndicator()
                : const SizedBox())),
      ),
      body: Stack(
        children: [
          Container(color: const Color.fromRGBO(52, 53, 65, 1)),
          Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                      controller: homepageController.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homepageController.messages.length,
                      itemBuilder: (_, index) =>
                          homepageController.messages[index],
                    )),
              ),
              textField(context)
            ],
          ),
          Obx(() => jumpToLast())
        ],
      ),
    );
  }

  Widget textField(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.only(
          left: 15.w,
        ),
        height: 50.h,
        width: MediaQuery.of(context).size.width - 50.w,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(64, 65, 79, 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextField(
          cursorColor: Colors.white,
          scrollPadding: const EdgeInsets.all(0),
          style: TextStyle(color: Colors.white, fontSize: 25.sp),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: -5),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                size: 35.r,
              ),
              color: Colors.white,
              onPressed: () => () {
                homepageController.addMessage(
                    Bubble(homepageController.textEditingcontroller.text));
              },
            ),
          ),
          controller: homepageController.textEditingcontroller,
          onSubmitted: (input) {
            homepageController.addMessage(Bubble(input));
          },
        ));
  }

  Widget jumpToLast() {
    return homepageController.isAtButton.value
        ? Positioned(
            bottom: 70.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                homepageController.jumpToLast();
              },
              child: ClipOval(
                child: Container(
                  color: Colors.grey,
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                    size: 40.r,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
      init: homepageController,
      id: "homepage",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
