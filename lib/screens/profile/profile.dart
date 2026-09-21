import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_box_app/core/features/follow/follow_controller.dart';
import 'package:recipe_box_app/core/features/profile/profile_controller.dart';
import 'package:recipe_box_app/core/features/providers.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/profile/widgets/saved_tab.dart';

import '../../core/features/profile/recipes/profile_recipe_controller.dart';
import 'widgets/profile_user_detail.dart';
import 'widgets/recipe_tab.dart';

class Profile extends ConsumerStatefulWidget {
  final String? userId;

  const Profile({
    super.key,
    this.userId,
  });

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  void _loadProfile() {
    final authManager = ref.read(authManagerProvider);

    final profileId = widget.userId ?? authManager.user?.id;

    if (profileId == null) {
      return;
    }

    ref.read(profileProvider.notifier).loadProfile(profileId);
    if (widget.userId == null) {
      ref.read(profileRecipeProvider.notifier).loadMyRecipes();
    }
  }

  Future<void> _toggleFollow(String userId) async {
    final result = await ref
        .read(followProvider.notifier)
        .toggleFollow(userId);

    if (result == null || !mounted) {
      return;
    }

    ref.read(profileProvider.notifier).updateFollowing(result);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final followState = ref.watch(followProvider);

    final authManager = ref.read(authManagerProvider);
    final currentUser = authManager.user;

    final profile = profileState.profile;

    final isOwnProfile = profile != null &&
        currentUser != null &&
        profile.id == currentUser.id;
    final tabCount = isOwnProfile ? 3 : 2;

    if (profileState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (profileState.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(profileState.errorMessage!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadProfile,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (profile == null) {
      return const Scaffold(
        body: Center(
          child: Text('Profile not found'),
        ),
      );
    }

    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (
              context,
              innerBoxIsScrolled,
              ) {
            return [
              SliverToBoxAdapter(
                child: ProfileUserDetail(
                  profile: profile,
                  isOwnProfile: isOwnProfile,
                  isFollowLoading:
                  followState.loadingIds.contains(profile.id),
                  onFollowChanged: () {
                    _toggleFollow(profile.id);
                  },
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                    TabBar(
                      tabs: [
                        const Tab(text: 'Recipes'),

                        if (isOwnProfile)
                          const Tab(text: 'Saved'),

                        const Tab(text: 'Reviews'),
                      ],
                    )
                ),
              ),
            ];
          },

          body: TabBarView(
            children: [
               RecipeTab(),

              if (isOwnProfile)
                const SavedTab(),

              const Center(
                child: Text('Reviews'),
              ),
            ],
          )
        ),
      ),
    );
  }
}

class _TabBarDelegate
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
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
  bool shouldRebuild(
      covariant SliverPersistentHeaderDelegate oldDelegate,
      ) {
    return false;
  }
}