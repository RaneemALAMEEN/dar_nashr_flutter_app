// lib/services/publisher_service.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dar_nashr/main.dart';
import 'package:dar_nashr/models/publisher_model.dart';
import 'package:dar_nashr/models/book_model.dart';

class PublisherService {
  final Dio _dio = Dio();

  Future<List<Publisher>> getPublishers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final resp = await _dio.get(
      '$url/users/publisher-houses',
      options: Options(headers: {
        'accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      }),
    );

    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((e) => Publisher.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('فشل تحميل دور النشر (${resp.statusCode})');
  }

  /// ✅ كتب دار نشر محددة
  Future<List<Book>> getBooksByPublisher(int publisherId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final resp = await _dio.get(
      '$url/users/publisher-houses/$publisherId/books',
      options: Options(headers: {
        'accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      }),
    );

    if (resp.statusCode == 200 && resp.data is List) {
      return (resp.data as List)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('فشل تحميل كتب الدار (${resp.statusCode})');
  }
}
