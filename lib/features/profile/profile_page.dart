import 'package:facebook_clone/features/auth/signin_page.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/repositories/auth_repo.dart';
import 'package:facebook_clone/repositories/user_repo.dart';
import 'package:facebook_clone/utils/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _userRepo = UserRepo();
  final _localStorage = LocalStorage();

  User? _currentUser;

  @override
  void initState() {
    super.initState();

    loadInfo();
  }

  void loadInfo() async {
    String currentUserId = await _localStorage.read('userId');
    User user = await _userRepo.getById(currentUserId);
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text('YOUR NAME IS ${_currentUser?.name}'), logOutButton()],
        ),
      ),
    );
  }

  Widget logOutButton() {
    return ElevatedButton(
        onPressed: () {
          LocalStorage().deleteAll();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
            (route) => false, // Remove all routes except the new one
          );
        },
        child: Text('Logout'));
  }
}
