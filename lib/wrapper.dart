import 'package:facebook_clone/features/auth/signin_page.dart';
import 'package:facebook_clone/features/home/home_page.dart';
import 'package:facebook_clone/features/navigator_page.dart';
import 'package:facebook_clone/repositories/auth_repo.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthRepo().isSignedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else {
          // Once the future completes, navigate to the appropriate page
          if (snapshot.data == true) {
            return NavigatorPage();
          } else {
            return SignInPage();
          }
        }
      },
    );
  }
}
