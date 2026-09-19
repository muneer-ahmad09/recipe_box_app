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
  // String-based to match OptionsTabs' existing changeValue(String) signature
  // rather than inventing a new enum-based API for it.
  String _selectedTab = "Ingredients";
  bool _isFavorite = false;

  // Mutable now — writing a review needs to append to this and rebuild.
  // Seeded from the static dummy data as a starting point.
  late final List<Map<String, dynamic>> _reviews = List.from(
    RecipePage.dummyReviews,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 460,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // IMAGE
                      Hero(
                        tag: 'recipe-image-${widget.id}',
                        child: Image.asset(
                          "assets/images/vegeta.jpg",
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Back button
                      Positioned(
                        top: 48,
                        left: 16,
                        child: _circleButton(
                          icon: Icons.arrow_back,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),

                      // Favorite button
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

                      // Recipe card
                      Positioned(
                        top: 260,
                        left: 20,
                        right: 20,
                        child: const RecipePageCard(),
                      ),
                    ],
                  ),
                ),
              ),

              // The toggle now lives here — pinned, and reusing your
              // actual OptionsTabs widget so it matches the rest of the
              // app's styling instead of a bar I invented.
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyOptionsTabs(
                  selected: _selectedTab,
                  onChanged: (value) => setState(() => _selectedTab = value),
                  topInset: MediaQuery.of(context).padding.top,
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                sliver: SliverToBoxAdapter(child: _buildTabContent()),
              ),
            ],
          ),

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
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = _ink,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 19,
        backgroundColor: _paper.withValues(alpha: 0.9),
        child: Icon(icon, color: iconColor, size: 19),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case "Steps":
        return Column(
          children: List.generate(RecipePage.dummySteps.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.petrol.withValues(alpha: 0.1),
                    child: Text(
                      '${i + 1}',
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
                      RecipePage.dummySteps[i],
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
      case "Reviews":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_reviews.length} reviews',
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: _showWriteReviewSheet,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 16, color: AppColors.petrol),
                      SizedBox(width: 4),
                      Text(
                        "Write a review",
                        style: TextStyle(
                          color: AppColors.petrol,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._reviews.map((r) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r["name"],
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: i < (r["rating"] as int)
                              ? _mustard
                              : _paperDim,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      r["comment"],
                      style: const TextStyle(color: _inkFaint, fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      case "Ingredients":
      default:
        return Column(
          children: RecipePage.dummyData
              .map((v) => RecipeCheckBox(ingredient: v["ingredient"]))
              .toList(),
        );
    }
  }

  void _showWriteReviewSheet() {
    int selectedRating = 0;
    final commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // lets the sheet resize above the keyboard instead of being covered by it
      backgroundColor: _paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        // Local state for the sheet — the star rating changes need their
        // own setState, separate from the page's, since this widget tree
        // lives in a different element than _RecipePageState's build().
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom:
                    20 +
                    MediaQuery.of(context)
                        .viewInsets
                        .bottom, // rides above the keyboard
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Write a review",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      final starValue = i + 1;
                      return GestureDetector(
                        onTap: () =>
                            setSheetState(() => selectedRating = starValue),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.star_rounded,
                            size: 32,
                            color: starValue <= selectedRating
                                ? _mustard
                                : _paperDim,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Tell other cooks how it went...",
                      filled: true,
                      fillColor: _paperDim,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                          AppColors.petrol,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      // Disabled until a star is picked — posting a 0-star
                      // review isn't a valid state.
                      onPressed: selectedRating == 0
                          ? null
                          : () {
                              // TODO: replace this local setState with the
                              // real API call once wired up:
                              //   POST /recipes/{widget.id}/reviews
                              //   body: {"rating": selectedRating, "comment": commentController.text}
                              //   header: Authorization: Bearer <access_token>
                              // On success, use the returned review (with
                              // real author name/id) instead of "You".
                              setState(() {
                                _reviews.insert(0, {
                                  "name": "You",
                                  "rating": selectedRating,
                                  "comment":
                                      commentController.text.trim().isEmpty
                                      ? "No comment."
                                      : commentController.text.trim(),
                                });
                              });
                              Navigator.pop(sheetContext);
                            },
                      child: const Text(
                        "Post review",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/// Wraps your existing OptionsTabs widget so it can pin to the top of
/// the scroll view once reached, instead of scrolling away with the
/// info card above it.
///
/// topInset is the status bar height (MediaQuery padding.top), passed
/// in from the parent because minExtent/maxExtent are plain getters
/// with no BuildContext — the delegate itself can't call MediaQuery.of.
/// This reserves permanent extra space so that once the header is
/// pinned at the very top of the viewport (physical pixel 0, since the
/// page deliberately isn't wrapped in a SafeArea so the hero image can
/// bleed under the status bar), the tab toggle still clears the status
/// bar instead of rendering underneath it.
class _StickyOptionsTabs extends SliverPersistentHeaderDelegate {
  final String selected;
  final ValueChanged<String> onChanged;
  final double topInset;

  _StickyOptionsTabs({
    required this.selected,
    required this.onChanged,
    required this.topInset,
  });

  @override
  double get minExtent => 64 + topInset;

  @override
  double get maxExtent => 64 + topInset;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, topInset + 10, 20, 10),
      decoration: BoxDecoration(
        color: _paper,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: OptionsTabs(
        options: const ["Ingredients", "Steps", "Reviews"],
        // extended from your original ["Ingredients","Steps"]
        changeValue: onChanged,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyOptionsTabs oldDelegate) =>
      oldDelegate.selected != selected || oldDelegate.topInset != topInset;
}
