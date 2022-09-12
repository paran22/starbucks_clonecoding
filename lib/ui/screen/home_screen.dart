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
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
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
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            renderSliverAppbar(),
            renderHeader(),
            renderSuggestions(),
            renderCardList(),
          ],
        ),
      ),
    );
  }

  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      // expandedHeight: 220,
      collapsedHeight: 220,
      scrolledUnderElevation: 50,
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
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [Text('1 star until next Reward')],
                ),
                Text('11/12')
              ],
            ),
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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/envelop.png',
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "What's New",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      child: SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/coupon.png',
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Coupon", style: TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      child: SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/alarm.png',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          maxHeight: 50,
          minHeight: 50,
        ));
  }

  SliverToBoxAdapter renderSuggestions() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        height: 250,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '가은',
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                ),
                Text(
                  '님을 위한 추천 메뉴',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/image/ice_americano.jpeg'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '아이스 카페 아메리카노',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  SliverList renderCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            renderCard(1),
            renderCard(2),
            renderCard(3),
          ],
        );
      }, childCount: 1),
    );
  }

  Widget renderCard(int number) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        'assets/image/card_sample$number.jpeg',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
