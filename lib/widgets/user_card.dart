import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String username;
  final String? imageUrl;

  final bool isFollowing;
  final bool isFollowLoading;
  final bool showFollowButton;

  final VoidCallback? onTap;
  final VoidCallback? onFollowChanged;

  const UserCard({
    super.key,
    required this.name,
    required this.username,
    this.imageUrl,
    this.isFollowing = false,
    this.isFollowLoading = false,
    this.showFollowButton = true,
    this.onTap,
    this.onFollowChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        leading: CircleAvatar(
          radius: 28,
          backgroundImage: imageUrl != null
              ? NetworkImage(imageUrl!)
              : null,
          child: imageUrl == null
              ? const Icon(Icons.person)
              : null,
        ),

        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),

        subtitle: Text(
          '@$username',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),

        trailing: showFollowButton
            ? _FollowButton(
          isFollowing: isFollowing,
          isLoading: isFollowLoading,
          onPressed: onFollowChanged,
        )
            : null,
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _FollowButton({
    required this.isFollowing,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,

      style: OutlinedButton.styleFrom(
        minimumSize: const Size(90, 40),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      child: isLoading
          ? const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      )
          : Text(
        isFollowing ? 'Following' : 'Follow',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}