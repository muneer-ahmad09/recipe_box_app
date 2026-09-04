import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/profile/widgets/stat.dart';

class ProfileUserDetail extends StatelessWidget {
  const ProfileUserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile picture
              const CircleAvatar(
                radius: 42,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 24),

              // Stats
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Stat(
                      value: '42',
                      label: 'Posts',
                    ),
                    Stat(
                      value: '12.5K',
                      label: 'Followers',
                    ),
                    Stat(
                      value: '324',
                      label: 'Following',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            'Muneer Ahmad',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Flutter Developer\n'
                'React Native • FastAPI • Spring Boot\n'
                'Building things that actually work 🚀',
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Edit profile'),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Share profile'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}