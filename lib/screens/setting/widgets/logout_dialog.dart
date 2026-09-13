import 'package:flutter/material.dart';

import '../../../core/auth/auth_manager.dart';

class LogoutDialog extends StatefulWidget {
  final AuthManager authManager;

  const LogoutDialog({super.key, required this.authManager});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool _isLoading = false;

  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.authManager.logout();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        Navigator.pop(context);
      }
    } catch(err){
        if(mounted){
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logout failed. Please try again.'),
            ),
          );
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Log out?', style: Theme
            .of(context)
            .textTheme
            .titleLarge),
        content: const Text(
            'Are you sure you want to log out of your account?'),
        actions: [
        TextButton(
        onPressed: ()
    {
      Navigator.pop(context);
    },
    child: const Text('Cancel'),
    ),
    TextButton(
    onPressed: _isLoading ? null : _logout,
    child: _isLoading
    ? const Text(
    'Log out',
    style: TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    )
        : const Text(
    'Log out',
    style: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    ),
    ),
    )
    ,
    ]
    ,
    );
  }
}
