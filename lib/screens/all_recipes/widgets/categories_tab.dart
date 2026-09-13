import 'package:flutter/cupertino.dart';
import 'package:recipe_box_app/widgets/category_button.dart';

class CategoriesTab extends StatefulWidget{

  final ValueChanged<String> onCategoryChanged;

  const CategoriesTab({super.key,required this.onCategoryChanged});

  @override
  State<StatefulWidget> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab>{

  final List<String> categories = [
  "Newest",
  "Popular",
  "Under 30 Min"
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: categories.map((category){
        return CategoryButton(
            buttonName: category,
            isActive: selectedCategory == category,
            callback: (){
              setState(() {
                selectedCategory = category;
              });
              widget.onCategoryChanged(category);
            }
        );
      }).toList(),
    );
  }

}