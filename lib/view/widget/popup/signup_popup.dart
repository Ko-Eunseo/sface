import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/default_avatar.dart';
import 'package:spec/view/widget/button/button_circle.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/textEditor/custom_input.dart';
import 'package:spec/view/widget/popup/edit_avatar_popup.dart';
import 'package:spec/view/widget/popup/popup.dart';

class SignupPopup extends StatelessWidget {
  const SignupPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Popup(
          isWide: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //아바타
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  //inputs
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      children: [
                        CustomInput(
                          label: '닉네임',
                          hint: '닉네임을 입력해주세요.',
                        ),
                        CustomInput(
                          label: '이메일',
                          hint: '이메일 주소를 입력해주세요.',
                        ),
                        CustomInput(
                          label: '휴대폰 번호',
                          hint: '휴대폰 번호를 입력해주세요.',
                        ),
                        CustomInput(
                          label: '링크 추가',
                          hint: 'LinkedIn URL',
                        ),
                        CustomInput(
                          hint: 'Github URL',
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInput(
                                hint: '개인 웹사이트 URL',
                              ),
                            ),
                            Expanded(
                              child: CustomInput(
                                hint: '개인 웹사이트 URL',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            text: '나중에 하기',
                            type: ButtonType.outline,
                            height: 32,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            text: '저장하기',
                            height: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Positioned(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppColor.primary05,
                child: Opacity(
                  opacity: 0.2,
                  child: DefaultAvatar(
                    width: 200,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '아바타 수정하기',
                    style: AppTextStyles.body12R(
                      color: AppColor.primary80,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleButton(
                    svg: 'assets/icons/svgs/edit.svg',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const EditAvatarPopup();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
