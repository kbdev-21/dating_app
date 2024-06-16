import 'dart:math';
import 'package:facebook_clone/common/styles.dart';
import 'package:facebook_clone/common/theme.dart';
import 'package:facebook_clone/features/auth/signin_page.dart';
import 'package:facebook_clone/features/home/matching_card.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/repositories/auth_repo.dart';
import 'package:facebook_clone/repositories/user_repo.dart';
import 'package:facebook_clone/utils/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userRepo = UserRepo();
  final _secureStorage = LocalStorage();

  List<User> _users = [];
  int _index = 0;

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  void loadUser() async {
    String userId = await _secureStorage.read('userId');
    List<User> apiUsers = await _userRepo.getForAUser(userId);
    apiUsers.shuffle(Random());
    setState(() {
      _users = apiUsers;
    });
  }

  void like() async {
    try {
      String user1Id = await _secureStorage.read('userId');
      String user2Id = _users[_index].id;

      bool isMatched = await _userRepo.userLikeOther(user1Id, user2Id);

      if (isMatched) {
        // Show some feedback for match
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("It's a match!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Liked!"),
        ));
      }

      setState(() {
        _users.removeAt(_index);
        if (_index >= _users.length) {
          _index = 0;
        }
      });
    } catch (e) {
      // Handle error
      print("Error liking user: $e");
    }
  }

  void deny() async {
    setState(() {
      if (_index == _users.length - 1) {
        _index = 0;
      } else {
        _index += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return _users.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
              children: [
                MatchingCard(
                  name: _users[_index].name,
                  imageURL: _users[_index].avtUrl,
                  age: 2024 - _users[_index].birthYear,
                  bio: _users[_index].bio,
                  denyButton: () {
                    deny();
                  },
                  likeButton: () {
                    like();
                  },
                ),

                //logOutButton()
              ],
            )),
          )
        : Center(child: CircularProgressIndicator());
  }


}
