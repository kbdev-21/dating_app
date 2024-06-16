import 'package:facebook_clone/common/styles.dart';
import 'package:facebook_clone/common/theme.dart';
import 'package:facebook_clone/feature/navigator_page.dart';
import 'package:facebook_clone/repository/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authRepo = AuthRepo();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthYearController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signup() async {
    final String name = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _password2Controller.text;
    final int birthYear = int.parse(_birthYearController.text);

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    bool isOk = await _authRepo.signUp(name, email, password, birthYear);
    if (isOk) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful')),
      );

      if (await _authRepo.signIn(email, password)) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigatorPage()),
          (route) => false, // Remove all routes except the new one
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup unsuccessful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
        ],
      ),
    );
  }

  Widget loadingIcon() {
    return Center(
      child: _isLoading
          ? Column(
              children: [
                SizedBox(height: 20),
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
          : SizedBox(height: 40),
    );
  }

  Widget forgotPassText() {
    return Center(
      child: Container(
        child: Text(
          'Forgot your password?',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget signInButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          // Handle sign in button press
          _signup();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 5,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _usernameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Enter your name',
            suffixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _birthYearController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Enter your year of birth',
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Enter your email',
            suffixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Set a password',
            suffixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _password2Controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm your password',
            suffixIcon: Icon(Icons.lock),
          ),
        ),
      ],
    );
  }

  Widget appIcon() {
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset('assets/images/app_icon.png', width: 80, height: 80),
    );
  }

  Widget welcomeText() {
    return Container(
      child: const Text(
        'Joining HeartBeat!',
        style: AppStyles.bold30,
      ),
    );
  }
}
