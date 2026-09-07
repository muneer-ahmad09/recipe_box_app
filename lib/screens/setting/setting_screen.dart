// import 'package:flutter/material.dart';
//
// class SettingScreen extends StatelessWidget {
//   const SettingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Settings',
//           style: Theme.of(context).textTheme.headlineMedium
//               ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 SizedBox(width: 20),
//                 Text("Account",style: Theme.of(context).textTheme.titleLarge,),
//               ],
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Edit Profile'),
//               trailing: Icon(Icons.arrow_forward_ios),
//             ),
//             ListTile(
//               leading: Icon(Icons.lock),
//               title: Text('Change Password'),
//               trailing: Icon(Icons.arrow_forward_ios),
//             ),
//             Row(
//               children: [
//                 SizedBox(width: 20),
//                 Text("Preferences",style: Theme.of(context).textTheme.titleLarge,),
//               ],
//             ),
//             ListTile(
//               leading: Icon(Icons.notifications),
//               title: Text('Notifications'),
//               trailing: Switch(
//                 value: true,
//                 onChanged: (value) {},
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.language),
//               title: Text('Language'),
//               trailing: Text('English'),
//             ),
//             ListTile(
//               leading: Icon(Icons.dark_mode),
//               title: Text('Dark Mode'),
//               trailing: Switch(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.login_rounded,color: Colors.red,),
//               title: Text('Log out',style: TextStyle(color: Colors.red),),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:recipe_box_app/screens/setting/widgets/logout_dialog.dart';
import 'package:recipe_box_app/screens/setting/widgets/section_title.dart';
import 'package:recipe_box_app/screens/setting/widgets/settings_container.dart';
import 'package:recipe_box_app/screens/setting/widgets/settings_divider.dart';
import 'package:recipe_box_app/screens/setting/widgets/settings_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        children: [
          // ACCOUNT
          SectionTitle(title: 'Account'),

          SettingsContainer(
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {},
              ),

              const SettingsDivider(),

              SettingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 28),

          // PREFERENCES
          SectionTitle(title: 'Preferences'),

          SettingsContainer(
            children: [
              SettingsTile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),

              const SettingsDivider(),

              SettingsTile(
                icon: Icons.language_rounded,
                title: 'Language',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'English',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                  ],
                ),
                onTap: () {},
              ),

              const SettingsDivider(),

              SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // LOGOUT
          SectionTitle(title: 'Account'),

          SettingsContainer(
            children: [
              SettingsTile(
                icon: Icons.logout_rounded,
                title: 'Log out',
                iconColor: Colors.red,
                titleColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const LogoutDialog();
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}





