import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';

class CategoryButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback callback;
  final bool? isActive;

  const CategoryButton({
    super.key,
    required this.buttonName,
    required this.callback,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(
        backgroundColor: isActive! ? AppColors.petrol : Colors.white,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        minimumSize: const Size(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Text(
        buttonName,
        style: isActive!
            ? Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.white
        )
            : Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
