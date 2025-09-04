
import 'package:dar_nashr/main.dart';
import 'package:dio/dio.dart';

class VerifyOtpService {
  final Dio _dio = Dio();

  Future<bool> verifyOtp({required String email, required String otp}) async {
     String url1 = '$url/verify-otp';

    try {
      Response response = await _dio.post(
        url1,
        data: {
          'email': email,
          'otp': otp,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['verified'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }
}
