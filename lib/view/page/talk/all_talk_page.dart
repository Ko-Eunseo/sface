import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/talk/all_talk_controller.dart';
import 'package:spec/view/widget/talk/talk_bubble_builder.dart';
import 'package:spec/view/widget/textEditor/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../util/app_color.dart';
import '../../widget/button/button_circle.dart';

class AllTalkPage extends GetView<AllTalkController> {
  const AllTalkPage({super.key});
  static const route = '/talk/all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: CircleButton(
        svg: 'assets/icons/svgs/Community_white.svg',
        iconWidth: 26,
        buttonWidth: 50,
        backColor: AppColor.primary80,
        onTap: () {
          controller.postNewTalkInPopup();
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (val) {
          print(val);
        },
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: CustomInput(
              type: InputType.search,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const NavMenu(
                    title: '톡톡톡',
                    titleDirection: TitleDirection.center,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(() {
                      if (controller.allTalksLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return TalkBubbleBuilder(
                          data: controller.allTalks,
                          onTalkUpdated: () async {
                            await controller.getAllTalks();
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
