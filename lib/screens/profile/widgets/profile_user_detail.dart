import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/models/user_profile_model.dart';

import 'stat.dart';

class ProfileUserDetail extends StatelessWidget {
  final UserProfileModel profile;
  final bool isOwnProfile;
  final bool isFollowLoading;
  final VoidCallback? onFollowChanged;

  const ProfileUserDetail({
    super.key,
    required this.profile,
    required this.isOwnProfile,
    this.isFollowLoading = false,
    this.onFollowChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: Colors.grey,
                backgroundImage: profile.avatarUrl != null
                    ? NetworkImage(profile.avatarUrl!)
                    : null,
                child: profile.avatarUrl == null
                    ? const Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.white,
                )
                    : null,
              ),

              const SizedBox(width: 24),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '@${profile.username}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    if (profile.bio != null &&
                        profile.bio!.trim().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        profile.bio!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Container(
            width: 300,
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stat(
                    value: profile.recipeCount.toString(),
                    label: 'Recipes',
                  ),

                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),

                  Stat(
                    value: profile.followerCount.toString(),
                    label: 'Followers',
                  ),

                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 20,
                      color: Colors.grey,
                    ),
                  ),

                  Stat(
                    value: profile.followingCount.toString(),
                    label: 'Following',
                  ),
                ],
              ),
            ),
          ),

          // Follow button only for other users.
          if (!isOwnProfile) ...[
            const SizedBox(height: 20),

            SizedBox(
              width: 160,
              height: 44,
              child: OutlinedButton(
                onPressed:
                isFollowLoading ? null : onFollowChanged,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isFollowLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  profile.isFollowing
                      ? 'Following'
                      : 'Follow',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}