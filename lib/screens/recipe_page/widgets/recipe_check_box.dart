import 'package:flutter/material.dart';

class RecipeCheckBox extends StatefulWidget{
  const RecipeCheckBox({super.key});

  @override
  State<StatefulWidget> createState() {
      return _RecipeCheckBoxState();
  }
}

class _RecipeCheckBoxState  extends State<RecipeCheckBox>{
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisSize: MainAxisSize.max,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        const Text("Enable feature"),
      ],
    );
  }
}