import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class OptionsTabs extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> changeValue;
  const OptionsTabs({super.key, required this.options, required this.changeValue});

  @override
  State<OptionsTabs> createState() => _OptionsTabsState();
}

class _OptionsTabsState extends State<OptionsTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.paper,
        border: Border.all(
            width: 1.5,
            color: Colors.grey.shade300
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: List.generate(widget.options.length, (index) {
          final option = widget.options[index];

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  widget.changeValue(option);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.cardWhite
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(option),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}