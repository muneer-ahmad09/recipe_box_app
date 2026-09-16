import 'package:flutter/material.dart';

import '../../../widgets/category_button.dart';

class AddItemDifficulty extends StatefulWidget {
  final ValueChanged<String> onDifficultyChanged;

  const AddItemDifficulty({super.key, required this.onDifficultyChanged});

  @override
  State<AddItemDifficulty> createState() => _AddItemDifficultyState();
}

class _AddItemDifficultyState extends State<AddItemDifficulty> {
  final List<String> difficulties = ["Easy", "Medium", "Hard"];

  String? selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Difficulty",
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: difficulties.map((difficulty) {
              return CategoryButton(
                buttonName: difficulty,
                callback: () {
                  setState(() {
                    selectedDifficulty = difficulty;
                  });

                  widget.onDifficultyChanged(difficulty);
                },
                isActive: selectedDifficulty == difficulty,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
