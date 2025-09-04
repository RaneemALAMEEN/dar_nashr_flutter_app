import 'package:dar_nashr/main.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "$url",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<dynamic>> getCategories({int skip = 0, int limit = 20}) async {
    try {
      final response = await dio.get(
        "/categories/",
        queryParameters: {"skip": skip, "limit": limit},
        options: Options(headers: {"accept": "application/json"}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("فشل في جلب التصنيفات");
      }
    } catch (e) {
      print(" خطأ getCategories: $e");
      return [];
    }
  }
}
