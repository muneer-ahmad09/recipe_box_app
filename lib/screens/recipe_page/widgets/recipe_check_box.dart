import 'package:flutter/material.dart';

class RecipeCheckBox extends StatefulWidget{
  final String ingredient;
  const RecipeCheckBox({
    super.key,
    required this.ingredient
  });

  @override
  State<StatefulWidget> createState() {
      return _RecipeCheckBoxState();
  }
}

class _RecipeCheckBoxState  extends State<RecipeCheckBox>{
  bool isChecked = false;
  bool taskDone=false;
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
              taskDone = !taskDone;
            });
          },
          side: BorderSide(
            width: 2.0
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(
          widget.ingredient,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            decoration: taskDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        )
      ],
    );
  }
}