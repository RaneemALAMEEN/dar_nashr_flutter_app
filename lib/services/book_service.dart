import 'package:dar_nashr/main.dart';
import 'package:dio/dio.dart';

class BookService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "$url",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<dynamic>> getAllBooks({int skip = 0, int limit = 10}) async {
    try {
      final response = await dio.get(
        "/books/",
        queryParameters: {"skip": skip, "limit": limit},
        options: Options(
          headers: {
            "accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("فشل في جلب الكتب");
      }
    } catch (e) {
      print(" خطأ في getAllBooks: $e");
      return [];
    }
  }
}
