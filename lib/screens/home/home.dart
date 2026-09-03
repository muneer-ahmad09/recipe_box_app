import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/home/widgets/header.dart';
import 'package:recipe_box_app/screens/home/widgets/home_page_recipe_card.dart';
import 'package:recipe_box_app/screens/recipe_page/recipe_page.dart';
import 'package:recipe_box_app/widgets/category_button.dart';
import 'package:recipe_box_app/widgets/custom_search_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 9.0, right: 9.0, top: 7.0),
      decoration: BoxDecoration(),
      child: Column(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(),
          CustomSearchBar(
            hintText: "Search recipes, ingredients...",
            onSearch: () {},
          ),
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.start,
            children: [
              CategoryButton(
                buttonName: "All",
                callback: () {
                  print("All Button Pressed");
                },
                isActive: true,
              ),
              CategoryButton(
                buttonName: "Breakfast",
                callback: () {
                  print("All Button Pressed");
                },
              ),
              CategoryButton(
                buttonName: "Dinner",
                callback: () {
                  print("All Button Pressed");
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Editor's picks",
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontSize: 30),
              ),
              Text("See all", style: TextStyle(color: AppColors.petrol)),
            ],
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = dummyData[index];
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomePageRecipeCard(
                      id:item["id"],
                      title: item["title"],
                      cookName: item["cookName"],
                      rating: item["rating"],
                      level: item["level"],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => RecipePage(id: item["id"],),
                      ),
                    );
                  },
                );
              },
              itemCount: dummyData.length,
            ),
          ),
        ],
      ),
    );
  }
}
