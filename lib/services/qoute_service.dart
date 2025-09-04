



// import 'package:dar_nashr/models/quote_model.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class QuoteService {
//   final Dio _dio = Dio(
//     BaseOptions(baseUrl: "https://project2copyrepo-12.onrender.com/"),
//   );

//   Future<List<Quote>> getQuotes({int skip = 0, int limit = 12}) async {
//     try {
//       final response = await _dio.get(
//         "/quotes/",
//         queryParameters: {"skip": skip, "limit": limit},
//       );

//       List data = response.data;
//       return data.map((e) => Quote.fromJson(e)).toList();
//     } catch (e) {
//       throw Exception("فشل في جلب الاقتباسات: $e");
//     }
//   }

//   Future<String?> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

//   Future<bool> toggleFavorite(int bookId) async {
//     try {
//       final token = await _getToken();
//       if (token == null) throw Exception("Token not found");

//       final response = await _dio.post(
//         "https://project2copyrepo-15.onrender.com/books/$bookId/like",
//         options: Options(
//           headers: {
//             "accept": "application/json",
//             "Authorization": "Bearer $token",
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         return true; // نجاح
//       }
//       return false;
//     } catch (e) {
//       rethrow;
//     }
//   }


 
//   Future<void> addQuote({
//     required String text,
//     required String bookName,
//     String? authorName,
//   }) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('access_token');

//     if (token == null) {
//       throw Exception("لا يوجد توكن. الرجاء تسجيل الدخول أولاً.");
//     }

//     try {
//       await _dio.post(
//         "/quotes/",
//         data: {
//           "text": text,
//           "book_name": bookName,
//           "author_name": authorName,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//     } catch (e) {
//       print(e);
//       throw Exception("فشل في إضافة الاقتباس: $e");
//     }
//   }
// }



import 'package:dar_nashr/main.dart';
import 'package:dar_nashr/models/qoute_model.com';
import 'package:dar_nashr/models/quote_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "$url"),
  );

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // ✅ جلب الاقتباسات
  Future<List<Quote>> getQuotes({int skip = 0, int limit = 10}) async {
    try {
      final token = await _getToken();
      final response = await _dio.get(
        "/quotes/",
        queryParameters: {"skip": skip, "limit": limit},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      List data = response.data;
      return data.map((e) => Quote.fromJson(e)).toList();
    } catch (e) {
      throw Exception("فشل في جلب الاقتباسات: $e");
    }
  }

  // ✅ إضافة اقتباس
  Future<void> addQuote({
    required String text,
    required String bookName,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception("Token not found");

    await _dio.post(
      "/quotes/",
      data: {
        "text": text,
        "book_name": bookName,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );
  }





  Future<bool> toggleLike(int quoteId) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception("Token not found");

      final response = await _dio.post(
        "/quotes/$quoteId/like",
        options: Options(
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}

  // // ✅ لايك على اقتباس
  // Future<bool> likeQuote(int quoteId) async {
  //   try {
  //     final token = await _getToken();
  //     if (token == null) throw Exception("Token not found");

  //     final response = await _dio.post(
  //       "/quotes/$quoteId/like",
  //       options: Options(
  //         headers: {
  //           "Authorization": "Bearer $token",
  //           "accept": "application/json",
  //         },
  //       ),
  //     );
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     throw Exception("فشل في الإعجاب بالاقتباس: $e");
  //   }
  // }

