import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/api_exception.dart';
import '../../services/user_services.dart';
import '../providers.dart';
import 'follow_state.dart';

class FollowController extends Notifier<FollowState> {
  late final UserServices _userServices;

  @override
  FollowState build() {
    _userServices = ref.read(userServicesProvider);

    return const FollowState();
  }

  Future<bool?> toggleFollow(String userId) async {
    // Prevent duplicate requests for the same user.
    if (state.loadingIds.contains(userId)) {
      return null;
    }

    state = state.copyWith(
      loadingIds: {
        ...state.loadingIds,
        userId,
      },
      errorMessage: null,
    );

    try {
      final result = await _userServices.toggleFollow(userId);

      return result.isFollowing;
    } on ApiException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
      );

      return null;
    } catch (_) {
      state = state.copyWith(
        errorMessage: 'Something went wrong. Please try again.',
      );

      return null;
    } finally {
      final updatedLoadingIds = {
        ...state.loadingIds,
      };

      updatedLoadingIds.remove(userId);

      state = state.copyWith(
        loadingIds: updatedLoadingIds,
      );
    }
  }
}

final followProvider =
NotifierProvider<FollowController, FollowState>(
  FollowController.new,
);