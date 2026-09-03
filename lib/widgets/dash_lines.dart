import 'package:flutter/material.dart';

class DashLines extends StatelessWidget {
  const DashLines({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            20,
            ((index) => Container(width: 8, height: 2, color: Colors.black26)),
          ),
        );
      },
    );
  }
}
