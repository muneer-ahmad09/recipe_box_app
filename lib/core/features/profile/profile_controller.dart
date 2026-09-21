import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/api_exception.dart';
import '../../services/user_services.dart';
import '../providers.dart';
import 'profile_state.dart';

class ProfileController extends Notifier<ProfileState> {
  late final UserServices _userServices;

  @override
  ProfileState build() {
    _userServices = ref.read(userServicesProvider);

    return const ProfileState();
  }

  Future<void> loadProfile(String userId) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final profile = await _userServices.getUserProfile(userId);

      state = state.copyWith(
        profile: profile,
        isLoading: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }


  void updateFollowing(bool isFollowing) {
    final profile = state.profile;

    if (profile == null) {
      return;
    }

    state = state.copyWith(
      profile: profile.copyWith(
        isFollowing: isFollowing,
        followerCount: isFollowing
            ? profile.followerCount + 1
            : profile.followerCount - 1,
      ),
    );
  }
}

final profileProvider =
NotifierProvider<ProfileController, ProfileState>(
  ProfileController.new,
);