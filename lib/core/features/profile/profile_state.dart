import '../../../models/user_profile_model.dart';

class ProfileState {
  final UserProfileModel? profile;
  final bool isLoading;
  final String? errorMessage;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  ProfileState copyWith({
    UserProfileModel? profile,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}