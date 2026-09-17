import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/network/api_exception.dart';
import 'package:recipe_box_app/screens/all_recipes/widgets/categories_tab.dart';

import '../../core/features/providers.dart';
import '../../models/recipe_card.dart';
import '../../models/recipe_enums.dart';
import '../../widgets/saved_recipe_card.dart';

class AllRecipesScreen extends ConsumerStatefulWidget {

  const AllRecipesScreen({super.key});

  @override
  ConsumerState<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends ConsumerState<AllRecipesScreen> {
  String selectedFilter = "Newest";
  List<RecipeCard> recipes = [];
  int currentPage = 1;
  bool _hasMore = true;
  int _requestId = 0;
  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  String? errorMessage;
  int? _failedPage;
  final Set<String> _favoriteLoadingIds = {};

  late final recipeService = ref.read(recipeServiceProvider);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _onFilterChange(value: selectedFilter, page: 1);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore || !_hasMore) {
      return;
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _onFilterChange(value: selectedFilter, page: currentPage + 1);
    }
  }

  void _checkIfMorePagesNeeded() {
    if (!_hasMore || _isLoadingMore) {
      return;
    }

    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent == 0) {
      _onFilterChange(value: selectedFilter, page: currentPage + 1);
    }
  }

  Future<void> _toggleFavorite(String recipeId) async {
    if (_favoriteLoadingIds.contains(recipeId)) {
      return;
    }

    try {
      setState(() {
        _favoriteLoadingIds.add(recipeId);
      });
      final result = await recipeService.toggleFavorite(recipeId);
      final recipeIndex = recipes.indexWhere((recipe) => recipe.id == recipeId);
      if (recipeIndex != -1) {
        setState(() {
          recipes[recipeIndex] = recipes[recipeIndex].copyWith(
            isFavorite: result.isFavorite,
          );
        });
      }
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _favoriteLoadingIds.remove(recipeId);
        });
      }
    }
  }

  Future<void> _loadRecipes({
    String sort = 'newest',
    int? maxCookMinutes,
    int page = 1,
    required int requestId,
  }) async {
    setState(() {
      if (page == 1) {
        _isInitialLoading = true;
      } else {
        _isLoadingMore = true;
      }

      errorMessage = null;
    });

    try {
      final apiRecipesList = await recipeService.getRecipes(
        page: page,
        sort: sort,
        maxCookMinutes: maxCookMinutes,
      );
      if (mounted && requestId == _requestId) {
        setState(() {
          if (page == 1) {
            recipes = apiRecipesList.items;
            _isInitialLoading = false;
          } else {
            recipes.addAll(apiRecipesList.items);
            _isLoadingMore = false;
          }
          currentPage = apiRecipesList.page;
          _hasMore = apiRecipesList.page < apiRecipesList.pages;
          _failedPage = null;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _checkIfMorePagesNeeded();
        });
      }
    } on ApiException catch (e) {
      if (mounted && requestId == _requestId) {
        setState(() {
          _failedPage = page;
          errorMessage = e.message;
          _isInitialLoading = false;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted && requestId == _requestId) {
        setState(() {
          errorMessage = 'Something went wrong. Please try again.';
          _failedPage = page;
          _isInitialLoading = false;
          _isLoadingMore = false;
        });
      }
    }
  }

  void _onFilterChange({required String value, required int page}) {
    final requestId = ++_requestId;
    switch (value) {
      case "Newest":
        _loadRecipes(sort: "newest", page: page, requestId: requestId);
        break;
      case "Popular":
        _loadRecipes(sort: "popular", page: page, requestId: requestId);
        break;
      case "Under 30 Min":
        _loadRecipes(maxCookMinutes: 30, page: page, requestId: requestId);
        break;
      default:
        _loadRecipes(sort: "newest", page: page, requestId: requestId);
        break;
    }
  }

  Widget _buildRecipeSection() {
    if (_isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (errorMessage != null &&
        errorMessage!.isNotEmpty &&
        recipes.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _onFilterChange(value: selectedFilter, page: currentPage);
            },
            child: const Text('Retry'),
          ),
        ],
      );
    } else if (recipes.isEmpty) {
      return const Center(child: Text("No recipes found"));
    } else {
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount:
            recipes.length + (_isLoadingMore || errorMessage != null ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == recipes.length) {
            if (_isLoadingMore) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(errorMessage!),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _onFilterChange(
                        value: selectedFilter,
                        page: _failedPage!,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SavedAndSearchRecipeCard(
            recipeName: recipes[index].title,
            recipeImageUrl: recipes[index].imageUrl,
            recipeTime: recipes[index].cookMinutes,
            recipeCategory: categoryEnumToString(recipes[index].category),
            isFavorite: recipes[index].isFavorite,
            onTapFavorite: () {
              _toggleFavorite(recipes[index].id);
            },
            isFavoriteLoading: _favoriteLoadingIds.contains(recipes[index].id),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Recipes')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CategoriesTab(
              selectedCategory: selectedFilter,
              onCategoryChanged: (value) {
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                }
                setState(() {
                  _isInitialLoading = true;
                  selectedFilter = value;
                  currentPage = 1;
                  _hasMore = true;
                  _failedPage = null;
                  errorMessage = null;
                });

                _onFilterChange(value: value, page: currentPage);
              },
            ),
          ),

          Expanded(child: _buildRecipeSection()),
        ],
      ),
    );
  }
}
