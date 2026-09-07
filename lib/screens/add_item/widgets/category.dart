import 'package:flutter/material.dart';

import '../../../widgets/category_button.dart';

class Category extends StatefulWidget {

  final ValueChanged<String> onCategoryChanged;

  const Category({super.key, required this.onCategoryChanged});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<String> categories = ["Dinner", "Breakfast", "Lunch", "Dessert"];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: categories.map((category) {
              return CategoryButton(
                buttonName: category,
                callback: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  widget.onCategoryChanged(category);
                },
                isActive: selectedCategory == category,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
