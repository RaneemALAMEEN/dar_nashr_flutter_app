// lib/services/job_application_service.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dar_nashr/main.dart'; // فيه المتغير url
import 'package:shared_preferences/shared_preferences.dart';

class JobApplicationService {
  final Dio _dio = Dio();

  Future<void> applyToVacancy({
    required int vacancyId,
    required File cvFile,
    String? coverLetter,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final headers = {
      'accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    final formData = FormData.fromMap({
      'cv_file': await MultipartFile.fromFile(cvFile.path,
          filename: cvFile.uri.pathSegments.last),
      if (coverLetter != null && coverLetter.trim().isNotEmpty) 'cover_letter': coverLetter,
    });

    final resp = await _dio.post(
      '$url/users/vacancies/$vacancyId/apply',
      data: formData,
      options: Options(headers: headers, contentType: 'multipart/form-data'),
    );

    if (resp.statusCode != 200) {
      throw Exception('فشل التقديم (${resp.statusCode})');
    }
  }
}
