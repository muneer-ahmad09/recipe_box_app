class CloudinarySignature {
  final String signature;
  final int timestamp;
  final String apiKey;
  final String cloudName;

  const CloudinarySignature({
    required this.signature,
    required this.timestamp,
    required this.apiKey,
    required this.cloudName,
  });

  factory CloudinarySignature.fromJson(Map<String, dynamic> json) {
    return CloudinarySignature(
      signature: json['signature'],
      timestamp: json['timestamp'],
      apiKey: json['api_key'],
      cloudName: json['cloud_name'],
    );
  }
}