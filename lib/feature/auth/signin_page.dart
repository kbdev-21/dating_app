import 'dart:convert';
import 'package:facebook_clone/common/styles.dart';
import 'package:facebook_clone/common/theme.dart';
import 'package:facebook_clone/feature/home/home_page.dart';
import 'package:facebook_clone/feature/navigator_page.dart';
import 'package:facebook_clone/repository/auth_repo.dart';
import 'package:facebook_clone/feature/auth/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _authRepo = AuthRepo();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    bool isOk = await _authRepo.signIn(email, password);
    if (isOk) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NavigatorPage()),
        (route) => false, // Remove all routes except the new one
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login unsuccessful')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appIcon(),
          SizedBox(height: 20),
          welcomeText(),
          SizedBox(height: 20),
          form(),
          loadingIcon(),
          SizedBox(height: 20),
          signInButton(),
          SizedBox(height: 20),
          forgotPassText(),
          //sendOTPButtonWidget(),
        ],
      ),
    );
  }

  Widget loadingIcon() {
    return Center(
        child: _isLoading
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                      strokeWidth: 3,
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: 40,
              ));
  }

  Widget forgotPassText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
        child: Container(
            child: Text(
          'Don\'t have an account? Create here',
          style: AppStyles.normal14.copyWith(color: Colors.grey)
        )),
      ),
    );
  }

  Widget signInButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10), // Optional margin
      child: ElevatedButton(
        onPressed: () {
          _signIn();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // Rounded corners
          ),
          elevation: 5, // Optional elevation
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'SIGN IN',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Enter your email',
                    suffixIcon: Icon(Icons.email_outlined)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Enter your password',
                    suffixIcon: Icon(Icons.lock_outline)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget appIcon() {
    return Align(
        alignment: Alignment.topLeft,
        child:
            Image.asset('assets/images/app_icon.png', width: 80, height: 80));
  }

  Widget welcomeText() {
    return Container(
      child: const Text(
        'Welcome back to\nHeartBeat',
        style: AppStyles.bold30,
      ),
    );
  }
}
