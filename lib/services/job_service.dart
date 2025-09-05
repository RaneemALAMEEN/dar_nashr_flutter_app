// lib/services/jobs_service.dart
import 'package:dar_nashr/models/job_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dar_nashr/main.dart';

class JobsService {
  final Dio _dio = Dio();

  Future<List<JobOpportunity>> getVacancies({int skip = 0, int limit = 10}) async {
    // التوكن اختياري (الـ curl لا يحتاجه، بس لو كان عندك توكن بنمرّرو)
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final resp = await _dio.get(
      '$url/users/vacancies',
      queryParameters: {'skip': skip, 'limit': limit},
      options: Options(headers: {
        'accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      }),
    );

    if (resp.statusCode == 200 && resp.data is List) {
      final list = (resp.data as List)
          .map((e) => JobOpportunity.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    }

    throw Exception('فشل تحميل فرص العمل (${resp.statusCode})');
  }
}
