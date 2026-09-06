import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/profile/widgets/profile_user_detail.dart';
import 'package:recipe_box_app/screens/profile/widgets/recipe_tab.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context,innerBoxIsScroller){
              return [SliverToBoxAdapter(
                child: ProfileUserDetail(),
                
              ),
                SliverPersistentHeader(
                  pinned: true,
                    delegate: _TabBarDelegate(
                      const TabBar(
                          tabs: [
                            Tab(
                              text:"Recipe",
                            ),
                            Tab(
                              text:"Saved",
                            ),
                            Tab(
                              text:"Reviews",
                            ),
                          ],
                      )
                    )
                )
              
              ];
            },
            // body: const TabBarView(children: [
            //   RecipeTab(),
            //   SavedTab(),
            //   ReviewTab(),
            // ])
          body: const TabBarView(
            children: [
              RecipeTab(),
              Center(child: Text('Reels')),
              Center(child: Text('Tagged')),
            ],
          ),
        )
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate{

  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
   return Container(
     color: AppColors.paper,
     child: tabBar,
   );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}