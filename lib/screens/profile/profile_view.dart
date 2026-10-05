import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/screens/profile/widgets/profile_reviews_tab.dart';
import 'package:recipe_box_app/screens/profile/widgets/profile_user_detail.dart';
import 'package:recipe_box_app/screens/profile/widgets/recips_tab.dart';
import 'package:recipe_box_app/screens/profile/widgets/saved_tab.dart';

import '../../core/features/follow/follow_controller.dart';
import '../../core/features/profile/profile_controller.dart';
import '../../core/features/profile/recipes/profile_recipe_controller.dart';
import '../../core/features/providers.dart';

class ProfileView extends ConsumerStatefulWidget {
  final String? userId;
  final bool showFollowButton;

  const ProfileView({
    super.key,
    this.userId,
    this.showFollowButton = true,
  });

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}
class _ProfileViewState extends ConsumerState<ProfileView> {
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

    final isOwnProfile =
        profile != null &&
            currentUser != null &&
            profile.id == currentUser.id;

    final tabCount = isOwnProfile ? 3 : 2;

    if (profileState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (profileState.errorMessage != null) {
      return Center(
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
      );
    }

    if (profile == null) {
      return const Center(
        child: Text('Profile not found'),
      );
    }

    return DefaultTabController(
      length: tabCount,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: ProfileUserDetail(
                profile: profile,
                isOwnProfile: isOwnProfile,

                // Important
                showFollowButton:
                widget.showFollowButton && !isOwnProfile,

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
                ),
              ),
            ),
          ];
        },

        body: TabBarView(
          children: [
            RecipeTab(),

            if (isOwnProfile)
              const SavedTab(),

            ProfileReviewsTab(
              userId: profile.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}