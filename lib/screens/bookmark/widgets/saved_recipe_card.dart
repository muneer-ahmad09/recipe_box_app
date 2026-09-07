import 'package:flutter/material.dart';

class SavedRecipeCard extends StatelessWidget {
  final String recipeName;
  final String recipeImageUrl;
  final int recipeTime;
  final String recipeCategory;

  const SavedRecipeCard({
    super.key,
    required this.recipeName,
    required this.recipeImageUrl,
    required this.recipeTime,
    required this.recipeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 14.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
            spacing: 25,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(recipeImageUrl, fit: BoxFit.cover)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipeName,style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      Text(recipeCategory,style: Theme.of(context).textTheme.bodyLarge,),
                      Text(" • ",style: Theme.of(context).textTheme.bodyLarge),
                      Text('${recipeTime.toString()} mins',style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),

                ],
              )
            ]
        ),
      ),
    );
  }
}
