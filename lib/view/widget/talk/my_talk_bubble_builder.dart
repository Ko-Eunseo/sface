import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/talk/talk.dart';
import 'talk_bubble.dart';

class MyTalkBubbleBuilder extends StatelessWidget {
  const MyTalkBubbleBuilder({
    super.key,
    required this.data,
    this.onTalkUpdated,
  });

  final RxList<Talk> data;
  final VoidCallback? onTalkUpdated;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) {
        if (index > data.length - 1) return const SizedBox.shrink();
        return const SizedBox(height: 16.0);
      },
      itemBuilder: (BuildContext context, int index) {
        var talk = data[index];
        return Container(
          constraints: const BoxConstraints(minHeight: 87),
          child: TalkBubble(
            talk: talk,
            type: BubbleType.myTalkEdit,
            onTapEnabled: true,
            onTalkUpdated: onTalkUpdated,
          ),
        );
      },
    );
  }
}
