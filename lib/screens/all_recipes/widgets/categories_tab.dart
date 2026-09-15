import 'package:flutter/cupertino.dart';
import 'package:recipe_box_app/widgets/category_button.dart';

class CategoriesTab extends StatefulWidget{

  final ValueChanged<String> onCategoryChanged;
  final String selectedCategory;

  const CategoriesTab({super.key,required this.onCategoryChanged, required this.selectedCategory});

  @override
  State<StatefulWidget> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab>{

  final List<String> categories = [
  "Newest",
  "Popular",
  "Under 30 Min"
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: categories.map((category){
        return CategoryButton(
            buttonName: category,
            isActive: widget.selectedCategory == category,
            callback: (){
              widget.onCategoryChanged(category);
            }
        );
      }).toList(),
    );
  }

}