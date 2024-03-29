import 'package:flutter/material.dart';
import 'package:spec/model/user/author.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';

class BestSpacerWidgetPage extends StatelessWidget {
  final Author bestSpacer;
  final bool isFirstPlace;
  final Widget badge; // 뱃지 위젯을 위한 새로운 파라미터 추가

  const BestSpacerWidgetPage({
    Key? key,
    required this.bestSpacer,
    this.isFirstPlace = false,
    required this.badge, // 필수 파라미터로 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = isFirstPlace ? 138 : 107;
    double height = isFirstPlace ? 165 : 137;

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserAvatar(
                avatarUrl: bestSpacer.avatar,
                shortName: bestSpacer.badge?.shortName,
                nickName: bestSpacer.nickname,
                direction: BadgeDirection.column,
                role: bestSpacer.role,
                roleHeight: width == 138 ? 22 : 17,
                avatarSize: width == 138 ? AvatarSize.w60 : AvatarSize.w40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text('${bestSpacer.temperature}'),
                ],
              ),
            ],
          ),
          // 조건에 따라 뱃지를 표시합니다.
          Positioned(
            right: 5,

            child: badge, // 뱃지 위젯을 위치시킵니다.
          ),
        ],
      ),
    );
  }
}
