


import 'package:dar_nashr/main.dart';
import 'package:dio/dio.dart';

class OtpService {
  static Future<bool> sendOtp(String email) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: {'email': email},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        print(' تم الإرسال ينجاح ');
        return true;
      } else {
        print('حدث خطأ في الإرسال: ${response.data}');
        return false;
      }
    } catch (e) {
      print(' Error sending OTP: $e');
      return false;
    }
  }
}
