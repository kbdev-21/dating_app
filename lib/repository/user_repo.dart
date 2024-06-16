import 'package:facebook_clone/config.dart';
import 'package:facebook_clone/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepo {
  Future<User> getById(String userId) async {
    final url = Uri.parse('${Config.serverIp}/api/users/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body)['user'];
      return User.fromJson(userData); // Assuming User.fromJson method is correctly implemented
    } else {
      throw Exception('Failed to get user by id');
    }
  }

  Future<List<User>> getAll() async {
    final url = Uri.parse('${Config.serverIp}/api/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<User>> getForAUser(String userId) async {
    final url = Uri.parse('${Config.serverIp}/api/usersFor/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<User>> getMatchedListById(String userId) async {
    final url = Uri.parse('${Config.serverIp}/api/users/matched/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['matchedUsers'];
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<bool> userLikeOther(String user1Id, String user2Id) async {
    final url = Uri.parse('${Config.serverIp}/api/users/like');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'userId': user1Id, 'likedUserId': user2Id}));

    if (response.statusCode == 200) {
      String resMsg = json.decode(response.body)['msg'];
      if (resMsg == "matched") return true;
      if (resMsg == "liked") return false;
    } else {
      throw Exception('Failed to like user');
    }

    return false;
  }
}
