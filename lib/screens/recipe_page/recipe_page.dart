import 'package:flutter/material.dart';

import 'package:recipe_box_app/core/theme/app_colors.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_check_box.dart';
import 'package:recipe_box_app/screens/recipe_page/widgets/recipe_page_card.dart';
import 'package:recipe_box_app/widgets/options_tab.dart';

const _paper = Color(0xFFF6F1E4);
const _paperDim = Color(0xFFEFE7D2);
const _ink = Color(0xFF2A2118);
const _inkFaint = Color(0xFF8A7F6C);
const _mustard = Color(0xFFE3A72E);
const _clayberry = Color(0xFFA6432B);

class RecipePage extends StatefulWidget {
  final String id;

  static const List<Map<String, dynamic>> dummyData = [
    {"id": 1, "ingredient": "Red Chilli"},
    {"id": 2, "ingredient": "Onion"},
    {"id": 3, "ingredient": "Garlic"},
    {"id": 4, "ingredient": "Ginger"},
    {"id": 5, "ingredient": "Tomato"},
    {"id": 6, "ingredient": "Potato"},
    {"id": 7, "ingredient": "Green Chilli"},
    {"id": 8, "ingredient": "Cumin Seeds"},
    {"id": 9, "ingredient": "Coriander Powder"},
    {"id": 10, "ingredient": "Turmeric Powder"},
    {"id": 11, "ingredient": "Garam Masala"},
    {"id": 12, "ingredient": "Black Pepper"},
    {"id": 13, "ingredient": "Cinnamon"},
    {"id": 14, "ingredient": "Cardamom"},
    {"id": 15, "ingredient": "Cloves"},
    {"id": 16, "ingredient": "Mustard Seeds"},
    {"id": 17, "ingredient": "Curry Leaves"},
    {"id": 18, "ingredient": "Fresh Coriander"},
    {"id": 19, "ingredient": "Lemon"},
    {"id": 20, "ingredient": "Salt"},
  ];

  static const List<String> dummySteps = [
    "Heat oil in a pan and add mustard seeds until they pop.",
    "Add onion, garlic, and ginger; sauté until golden.",
    "Stir in the tomatoes and cook until softened.",
    "Add the spices and potatoes, then simmer until tender.",
    "Finish with fresh coriander and a squeeze of lemon.",
  ];

  static const List<Map<String, dynamic>> dummyReviews = [
    {
      "name": "Dev Patel",
      "rating": 5,
      "comment": "Salty-sweet balance is perfect.",
    },
    {
      "name": "Sofia M.",
      "rating": 4,
      "comment": "Great flavor, added extra chili.",
    },
  ];

  const RecipePage({super.key, required this.id});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String _selectedTab = "Ingredients";

  bool _isFavorite = false;

  static const List<String> _tabs = ["Ingredients", "Steps", "Reviews"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
    
      body: SafeArea(
        top:true,
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // ============================================================
                // IMAGE + RECIPE CARD
                // ============================================================
            
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 360,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ----------------------------------------------------
                        // RECIPE IMAGE
                        // ----------------------------------------------------
            
                        Hero(
                          tag: 'recipe-image-${widget.id}',
                          child: Image.asset(
                            "assets/images/vegeta.jpg",
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
            
                        // ----------------------------------------------------
                        // BACK BUTTON
                        // ----------------------------------------------------
                        Positioned(
                          top: 48,
                          left: 16,
                          child: _circleButton(
                            icon: Icons.arrow_back,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
            
                        // ----------------------------------------------------
                        // FAVORITE BUTTON
                        // ----------------------------------------------------
                        Positioned(
                          top: 48,
                          right: 16,
                          child: _circleButton(
                            icon: _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            iconColor: _clayberry,
                            onTap: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                          ),
                        ),
            
                        // ----------------------------------------------------
                        // RECIPE CARD
                        //
                        // Image ends at 300.
                        // Card starts at 260.
                        //
                        // Therefore the card overlaps the image by 40px.
                        // ----------------------------------------------------
                        Positioned(
                          top: 230,
                          left: 20,
                          right: 20,
                          child: RecipePageCard(),
                        ),
                      ],
                    ),
                  ),
                ),
            
                // ============================================================
                // STICKY TABS
                // ============================================================
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyOptionsTabs(
                    selected: _selectedTab,
                    options: _tabs,
                    onChanged: _onTabChanged,
                  ),
                ),
            
                // ============================================================
                // TAB CONTENT
                // ============================================================
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                  sliver: SliverToBoxAdapter(child: _buildTabContent()),
                ),
              ],
            ),
            
            // ================================================================
            // START COOKING BUTTON
            // ================================================================
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
            
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      AppColors.petrol,
                    ),
            
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
            
                  child: Text(
                    "Start cooking",
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // TAB CHANGE
  // ========================================================================

  void _onTabChanged(String value) {
    if (!_tabs.contains(value)) {
      return;
    }

    if (value == _selectedTab) {
      return;
    }

    setState(() {
      _selectedTab = value;
    });
  }

  // ========================================================================
  // CIRCLE BUTTON
  // ========================================================================

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = _ink,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 19,
        backgroundColor: _paper.withOpacity(0.9),
        child: Icon(icon, color: iconColor, size: 19),
      ),
    );
  }

  // ========================================================================
  // TAB CONTENT
  // ========================================================================

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case "Steps":
        return _buildSteps();

      case "Reviews":
        return _buildReviews();

      case "Ingredients":
      default:
        return _buildIngredients();
    }
  }

  // ========================================================================
  // INGREDIENTS
  // ========================================================================

  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: RecipePage.dummyData.map((ingredient) {
        return RecipeCheckBox(ingredient: ingredient["ingredient"] as String);
      }).toList(),
    );
  }

  // ========================================================================
  // STEPS
  // ========================================================================

  Widget _buildSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(RecipePage.dummySteps.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.petrol.withOpacity(0.1),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: AppColors.petrol,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  RecipePage.dummySteps[index],
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ========================================================================
  // REVIEWS
  // ========================================================================

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: RecipePage.dummyReviews.map((review) {
        final int rating = review["rating"] as int;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review["name"] as String,
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 3),

              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: index < rating ? _mustard : _paperDim,
                  );
                }),
              ),

              const SizedBox(height: 4),

              Text(
                review["comment"] as String,
                style: const TextStyle(color: _inkFaint, fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================================
// STICKY OPTIONS TABS
// ============================================================================

class _StickyOptionsTabs extends SliverPersistentHeaderDelegate {
  final String selected;
  final List<String> options;
  final ValueChanged<String> onChanged;

  _StickyOptionsTabs({
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  double get minExtent => 64.0;

  @override
  double get maxExtent => 64.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: _paper,
      child: Container(
        height: 64,

        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

        decoration: BoxDecoration(
          color: _paper,

          boxShadow: overlapsContent
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),

        child: OptionsTabs(
          key: ValueKey<String>(selected),
          options: options,
          changeValue: onChanged,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyOptionsTabs oldDelegate) {
    return oldDelegate.selected != selected;
  }
}
