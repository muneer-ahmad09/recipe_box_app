import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/notifications/route_arguments.dart';


import 'navigation_keys.dart';

class NotificationRouter {
   NotificationRouter();

  Map<String, dynamic>? _pendingData;

  void handle(Map<String, dynamic> data) {
    if (data.isEmpty) {
      return;
    }

    if (mainNavigatorKey.currentState == null) {
      _pendingData = data;
      debugPrint('Notification stored until navigator is ready.');
      return;
    }

    _route(data);
  }


  void handlePending() {
    final data = _pendingData;

    if (data == null) {
      return;
    }

    _pendingData = null;

    _route(data);
  }

   void _route(Map<String, dynamic> data) {
     switch (data['type']) {
       case 'new_follower':
         _openFollowerProfile(data);
         break;

       case 'new_review':
         _openRecipe(data);
         break;

       default:
         debugPrint(
           'Unknown notification type: ${data['type']}',
         );
     }
   }

   void _openRecipe(Map<String, dynamic> data) {
     final recipeId = data['recipe_id'];

     if (recipeId == null) {
       debugPrint('new_review notification missing recipe_id');
       return;
     }

     mainNavigatorKey.currentState?.pushNamed(
       '/recipe',
       arguments: RecipeRouteArguments(
         id: recipeId.toString(),
       ),
     );
   }

   void _openFollowerProfile(
       Map<String, dynamic> data,
       ) {
     final followerId = data['follower_id'];

     if (followerId == null) {
       debugPrint(
         'new_follower notification missing follower_id',
       );
       return;
     }

     mainNavigatorKey.currentState?.pushNamed(
       '/profile',
       arguments: ProfileRouteArguments(
         userId: followerId.toString(),
       ),
     );
   }


}