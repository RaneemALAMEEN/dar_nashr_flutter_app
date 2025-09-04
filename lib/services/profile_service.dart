// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileService {
//   final Dio _dio = Dio();

//   Future<String?> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

//   Future<Map<String, dynamic>> getProfile() async {
//     try {
//       final token = await _getToken();
//       if (token == null) throw Exception("Token not found");

//       final response = await _dio.get(
//         'https://project2copyrepo-12.onrender.com/users/me',
//         options: Options(
//           headers: {
//             "accept": "application/json",
//             "Authorization": "Bearer $token",
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception("Failed to fetch profile");
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }



// Future<Map<String, dynamic>> updateProfile({
//   String? bio,
//   String? socialLinks,
// }) async {
//   try {
//     final token = await _getToken();
//     if (token == null) throw Exception("Token not found");

//     final response = await _dio.put(
//       'https://project2copyrepo-12.onrender.com/users/me',
//       data: {
//         if (bio != null) 'bio': bio,
//         if (socialLinks != null) 'social_links': socialLinks,
//       },
//       options: Options(
//         headers: {
//           "accept": "application/json",
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/x-www-form-urlencoded",
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       throw Exception("Failed to update profile");
//     }
//   } catch (e) {
//     rethrow;
//   }
// }
// }


import 'package:dar_nashr/main.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final Dio _dio = Dio();

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception("Token not found");

      final response = await _dio.get(
        '$url/users/me',
        options: Options(
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to fetch profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? bio,
    String? socialLinks,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception("Token not found");

      final response = await _dio.put(
        'https://project2copyrepo-15.onrender.com/users/me',
        data: {
          if (bio != null) 'bio': bio,
          if (socialLinks != null) 'social_links': socialLinks,
        },
        options: Options(
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      rethrow;
    }
  }
}
