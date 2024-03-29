import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class DescriptionWithOneButton extends StatelessWidget {
  const DescriptionWithOneButton(
      {super.key,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle});

  final String mainMessage;
  final String subMessage;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      content: SizedBox(
        width: 242,
        height: 153,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              mainMessage,
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              subMessage,
              style: AppTextStyles.body12R(color: const Color(0xFF999999)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  size: ButtonSize.small,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: '${buttonTitle}',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showDialog_7(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DescriptionWithOneButton(
        mainMessage: '삭제할거니',
        subMessage: '진짜니',
        buttonTitle: '웅그!',
      );
    },
  );
}
