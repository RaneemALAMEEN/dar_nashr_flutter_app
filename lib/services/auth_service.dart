
import 'package:dar_nashr/main.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';

class AuthService {
  Dio dio = Dio();

  Future<bool> login({required LoginModel loginInfo}) async {
    try {
      Response response = await dio.post(
        '$url/login',
        data: loginInfo.toMap(),
      );

      if (response.statusCode == 200) {
        String token = response.data['access_token'];
        String role = response.data['role'];
        int userId = response.data['user_id'];

        print(' Login successful');
        print('Token: $token');
        print('Role: $role');
        print('User ID: $userId');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setString('role', role);
        await prefs.setInt('user_id', userId);

        return true;
      } else {
        print(' Login failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(' Error during login: $e');
      return false;
    }
  }
}
