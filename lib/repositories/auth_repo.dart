import 'dart:convert';
import 'package:facebook_clone/config.dart';
import 'package:facebook_clone/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<bool> signUp(String name, String email, String password, int birthYear) async {
    final url = Uri.parse('${Config.serverIp}/auth/signup');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'birthYear': birthYear
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    final url = Uri.parse('${Config.serverIp}/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String token = responseBody['userToken'];
      final String userId = responseBody['user']['_id'];
      LocalStorage().write('token', token);
      LocalStorage().write('userId', userId);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> isSignedIn() async {
    String token = await LocalStorage().read('token');

    final url = Uri.parse('${Config.serverIp}/auth/currentUser');
    final response = await http.get(
      url,
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
