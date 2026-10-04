import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/notifications/route_arguments.dart';

import 'navigation_keys.dart';

class NotificationRouter {
  const NotificationRouter();

  void handle(Map<String, dynamic> data) {
    final type = data['type'];

    switch (type) {
      case 'recipe_liked':
        _openRecipe(data);
        break;

      default:
        debugPrint('Unknown notification type: $type');
    }
  }

  void _openRecipe(Map<String, dynamic> data) {
    final recipeId = data['recipeId'];

    if (recipeId == null) {
      debugPrint('recipe_liked notification missing recipeId');
      return;
    }

    mainNavigatorKey.currentState?.pushNamed(
      '/recipe',
      arguments: RecipeRouteArguments(
        id: recipeId.toString(),
      ),
    );
  }
}