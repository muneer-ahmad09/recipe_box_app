import 'package:recipe_box_app/core/network/api_client.dart';

import '../../models/page.dart';
import '../../models/user_card_model.dart';

class SearchService {
  final ApiClient apiClient;

  SearchService(this.apiClient);

  Future<Page<UserCardModel>> searchUsers({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) {
    return apiClient.searchUsers(query: query, page: page, pageSize: pageSize);
  }
}
