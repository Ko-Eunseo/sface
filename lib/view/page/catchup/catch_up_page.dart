import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/model/catchup/catchup.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/card/widget_card.dart';
import '../../../controller/catchup/catchup_controller.dart';
import 'package:intl/intl.dart';
import 'Hot_catch_up_page.dart';
import '../../../../util/app_color.dart';

class CatchUpPage extends GetView<CatchUpController> {
  static const String route = '/catchup';
  final ScrollController _scrollController = ScrollController();

  CatchUpPage({super.key}) {
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCatchUp();
      controller.HotCatchup();
    });

    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        // 스와이프 방향이 오른쪽으로 갔는지 체크합니다.
        if (dragEndDetails.primaryVelocity! > 0) {
          // 속도가 양수이면 오른쪽으로 스와이프 된 것입니다.
          Navigator.of(context).pop(); // 현재 페이지를 닫습니다.
        }
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: 2,
            onTap: (val) {
              print(val);
            },
          ),
          backgroundColor: Colors.grey[200],
          appBar: const CustomAppBar(),
          body: Column(
            children: [
              _buildSearchTextField(),
              NavMenu(
                  title: '핫한 캐치업!',
                  titleDirection: TitleDirection.left,
                  withEmoji: true,
                  emoji: 'assets/icons/pngs/dart.png',
                  onButtonPressed: () => Get.to(const HotCatchUp())),
              _buildHotCatchUpsSection(),
              NavMenu(
                  title: '캐치업!',
                  titleDirection: TitleDirection.left,
                  withEmoji: true,
                  emoji: 'assets/icons/pngs/dart.png',
                  onButtonPressed: () => Get.to(const HotCatchUp())),
              Expanded(child: _buildFlexibleCatchUpsListView()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    controller.searchTextcontroller.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // 사용자가 최상단에 도달했습니다.
        // 여기서 추가 로직을 구현할 수 있습니다.
      }
    }
  }

  // '핫한 캐치업' 섹션을 구성하는 위젯
  Widget _buildHotCatchUpsSection() {
    return SizedBox(
      height: 220,
      child: Obx(() {
        var hotCatchUpsList = controller.hotCatchUps.value;
        return _buildHotListView(hotCatchUpsList);
      }),
    );
  }

  // '핫한 캐치업' 리스트뷰 빌더
  Widget _buildHotListView(List<CatchUp> hotCatchUpsList) {
    return Align(
      alignment: Alignment.center,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotCatchUpsList.length,
        itemBuilder: (context, index) {
          final catchUp = hotCatchUpsList[index];

          // 날짜 포맷팅
          final createdAtDate = DateTime.parse(catchUp.createdAt);
          final dateOnly = DateTime(
              createdAtDate.year, createdAtDate.month, createdAtDate.day);
          final formattedDate = DateFormat('yyyy.MM.dd').format(dateOnly);

          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardWidget(
                minibadge:
                    catchUp.author?.role ?? ' null', // 이 필드는 이전 예제와 동일하게 처리
                temperature: catchUp.upProfiles.length.toString(),
                avatar: catchUp.author?.avatar ?? 'assets/icons/pngs/man-a.png',
                position: catchUp.author?.badge?.shortName ??
                    'Unknown Position', // 기본값 예시
                nickname: catchUp.author?.nickname ?? 'null',
                url: catchUp.url,
                hashTags: catchUp.hashtag ?? '태그가 없어요 ㅠㅠ',
                thumbnail: catchUp.thumbnail ?? 'null',
                description: catchUp.title ?? 'null',
                createdTime: formattedDate ?? 'null',
                postId: catchUp.id ?? 'null',
              ));
        },
      ),
    );
  }

  // 주요 캐치업 ListView를 구성하는 Flexible 위젯
  Widget _buildFlexibleCatchUpsListView() {
    return Obx(() {
      var catchUpsList = controller.isSearching.isTrue
          ? controller.searchCatchUps.value
          : controller.catchUps.value;
      return Column(
        children: [
          Expanded(child: _buildListView(catchUpsList)),
        ],
      );
    });
  }

  // 주요 캐치업 리스트뷰 빌더
  // 주요 캐치업 리스트뷰 빌더
  ListView _buildListView(List<CatchUp> catchUpsList) {
    return ListView.builder(
      itemCount: catchUpsList.length,
      itemBuilder: (context, index) {
        final catchUp = catchUpsList[index];

        // 날짜 포맷팅
        final createdAtDate = DateTime.parse(catchUp.createdAt);
        final dateOnly = DateTime(
            createdAtDate.year, createdAtDate.month, createdAtDate.day);
        final formattedDate = DateFormat('yyyy.MM.dd').format(dateOnly);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CardWidget(
            minibadge: catchUp.author?.role ?? ' null', // 이 필드는 이전 예제와 동일하게 처리
            temperature: catchUp.upProfiles.length.toString(),
            avatar: catchUp.author?.avatar ?? 'assets/icons/pngs/man-a.png',
            position: catchUp.author?.badge?.shortName ?? '관리자', // 기본값 예시
            nickname: catchUp.author?.nickname ?? 'null',
            url: catchUp.url,
            hashTags: catchUp.hashtag ?? '태그가 없어요 ㅠㅠ',
            thumbnail: catchUp.thumbnail ?? 'null',
            description: catchUp.title ?? 'null',
            createdTime: formattedDate ?? 'null',
            postId: catchUp.id ?? 'null',
          ),
        );
      },
    );
  }

  // 검색 필드 위젯
  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Theme(
            data: ThemeData().copyWith(
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: AppColor.primary80)),
            child: TextField(
              controller: controller.searchTextcontroller,
              onChanged: (value) {
                if (value.isEmpty) {
                  controller.endSearch();
                }
              },
              onSubmitted: (value) {
                controller.startSearch(value);
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {
                      controller
                          .startSearch(controller.searchTextcontroller.text);
                    },
                    icon: const Icon(Icons.search)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: '내용 검색하기',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.black10),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primary40),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
