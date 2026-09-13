import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/auth/auth_manager.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/all_recipes/all_recipes_screen.dart';
import 'package:recipe_box_app/screens/home/widgets/header.dart';
import 'package:recipe_box_app/screens/home/widgets/home_page_recipe_card.dart';
import 'package:recipe_box_app/screens/recipe_page/recipe_page.dart';
import 'package:recipe_box_app/widgets/category_button.dart';
import 'package:recipe_box_app/widgets/custom_search_bar.dart';

import '../../core/services/recipe_service.dart';
import '../../models/recipe_card.dart';

class Home extends StatefulWidget {
  final AuthManager authManager;
  final RecipeService recipeService;
  const Home({super.key, required this.authManager, required this.recipeService});

  static const List dummyData = [
    {
      "id": 1,
      "title": "Brow Butter Misco Cookies",
      "cookName": "Jo Ainsworth",
      "rating": 4.8,
      "level": "Easy",
    },
    {
      "id": 2,
      "title": "Brow Butter Misco Cookies",
      "cookName": "Jo Ainsworth",
      "rating": 4.8,
      "level": "Easy",
    },
    {
      "id": 3,
      "title": "Brow Butter Misco Cookies",
      "cookName": "Jo Ainsworth",
      "rating": 4.8,
      "level": "Easy",
    },
  ];


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<RecipeCard> recipes = [];

  String? selectedCategory;
  List<String> categories = [
    "All",
    "Breakfast",
    "Dinner"
  ];

  Future<void> _loadRecipes() async {
    final page = await widget.recipeService.getNewestRecipes();
    setState(() {
      recipes = page.items;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 9.0, right: 9.0, top: 7.0),
      decoration: BoxDecoration(),
      child: Column(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(user: widget.authManager.user!,),
          CustomSearchBar(
            elevateSearchBar: true,
            hintText: "Search recipes, ingredients...",
            onSearch: () {},
          ),
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.start,
            children: categories.map((category) {
              return CategoryButton(
                buttonName: category,
                isActive: selectedCategory == category,
                callback: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Editor's picks",
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontSize: 30),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllRecipesScreen()),
                  );
                },
                child: Text(
                  "See all",
                  style: TextStyle(color: AppColors.petrol),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = recipes[index];
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomePageRecipeCard(
                      id: item.id,
                      title: item.title,
                      imageUrl: item.imageUrl,
                      cookName: item.author,
                      rating: item.ratingAvg,
                      level: item.difficulty,
                      cookMinutes: item.cookMinutes,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RecipePage(id: item.id),
                      ),
                    );
                  },
                );
              },
              itemCount:recipes.length,
            ),
          ),
        ],
      ),
    );
  }
}
