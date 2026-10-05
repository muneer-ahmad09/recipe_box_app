import 'package:flutter/material.dart';


import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ProfileView(
        userId: userId,
        showFollowButton: false,
      ),
    );
  }
}
