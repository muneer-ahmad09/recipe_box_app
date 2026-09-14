import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/auth/auth_manager.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/all_recipes/all_recipes_screen.dart';
import 'package:recipe_box_app/screens/home/widgets/header.dart';
import 'package:recipe_box_app/screens/home/widgets/home_page_recipe_card.dart';
import 'package:recipe_box_app/screens/recipe_page/recipe_page.dart';
import 'package:recipe_box_app/widgets/category_button.dart';
import 'package:recipe_box_app/widgets/custom_search_bar.dart';

import '../../core/network/api_exception.dart';
import '../../core/services/recipe_service.dart';
import '../../models/recipe_card.dart';

class Home extends StatefulWidget {
  final AuthManager authManager;
  final RecipeService recipeService;

  const Home({
    super.key,
    required this.authManager,
    required this.recipeService,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeCard> recipes = [];

  bool _isLoading = true;
  String? errorMessage;

  String? selectedCategory = "All";
  List<String> categories = ["All", "Breakfast", "Dinner"];

  Future<void> _loadRecipes() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });
    try {
      final page = await widget.recipeService.getNewestRecipes(
        category: selectedCategory == "All" ? null : selectedCategory,
      );
      if (mounted) {
        setState(() {
          recipes = page.items;
          _isLoading = false;
        });
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Something went wrong. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildRecipeSection() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (errorMessage != null && errorMessage!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage!),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadRecipes, child: const Text('Retry')),
        ],
      );
    } else if (recipes.isEmpty) {
      return const Center(child: Text("No recipes found"));
    } else {
      return ListView.builder(
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
                  builder: (BuildContext context) => RecipePage(id: item.id),
                ),
              );
            },
          );
        },
        itemCount: recipes.length,
      );
    }
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
          Header(user: widget.authManager.user!),
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
                  _loadRecipes();
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
          SizedBox(height: 320, child: _buildRecipeSection()),
        ],
      ),
    );
  }
}
