import 'package:recipe_box_app/core/network/api_client.dart';

import '../../models/follow_api_model.dart';
import '../../models/user_profile_model.dart';

class UserServices {
  final ApiClient apiClient;

  const UserServices(this.apiClient);

  Future<FollowApiModel> toggleFollow(String userId) async {
    return apiClient.toggleFollow(userId);
  }

  Future<UserProfileModel> getUserProfile(String userId) async {
    return apiClient.getUserProfile(userId);
  }
}
