import 'dart:io';

import 'package:dio/dio.dart';

import '../network/api_client.dart';
import '../network/api_exception.dart';

class CloudinaryService {
  final ApiClient apiClient;
  final Dio dio;

  CloudinaryService({required this.apiClient, required this.dio});

  Future<String> uploadImage(File image) async {
    final signature = await apiClient.getCloudinarySignature();

    final file = await MultipartFile.fromFile(
      image.path,
    );
    final formData = FormData.fromMap({
      'file': file,
      'api_key': signature.apiKey,
      'timestamp': signature.timestamp,
      'signature': signature.signature,
    });
    final url =
        'https://api.cloudinary.com/v1_1/${signature.cloudName}/image/upload';

    try {
      final response = await dio.post(
        url,
        data: formData,
      );

      final imageUrl = response.data['secure_url'];

      if (imageUrl is! String || imageUrl.isEmpty) {
        throw ApiException(
          'Image upload succeeded, but no image URL was returned.',
        );
      }

      return imageUrl;
    } on DioException {
      throw ApiException(
        'Failed to upload image. Please try again.',
      );
    }
  }
}