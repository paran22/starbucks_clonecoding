import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate(
      {required this.maxHeight, required this.minHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // 최대높이
  double get maxExtent => maxHeight;

  @override
  // 최소높이
  double get minExtent => minHeight;

  @override
  // covariant : 상속된 클래스도 사용가능
  // oldDelegete - build가 실행 됬을 때 이전 delegate
  // this - 새로운 delegate
  // shouldRebuild - 새로 build를 해야할지 말지 결정
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}


class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            renderSliverAppbar(),
            renderHeader(),
            renderCardList(),
          ],
        ),
      ),
    );
  }

  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      expandedHeight: 220,
      collapsedHeight: 220,
      flexibleSpace: Column(
        children: [
          SizedBox(
            height: 170,
            child: Image.asset(
              'assets/image/appbar.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('1 star until next Reward')
                  ],
                ),
                Text('11/12')
              ],
            )),
          )
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverFixedHeaderDelegate(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                'test',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          maxHeight: 50,
          minHeight: 50,
        ));
  }

  SliverList renderCardList() {
    return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      return Container(
        height: 200,
        color: Colors.orange,
      );
    }),
    );
  }
}
