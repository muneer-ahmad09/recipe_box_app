class TokenPair {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  TokenPair({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory TokenPair.fromJson(Map<String, dynamic> json) {
    return TokenPair(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
    );
  }

}