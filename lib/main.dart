import 'package:facebook_clone/common/theme.dart';
import 'package:facebook_clone/feature/auth/signin_page.dart';
import 'package:facebook_clone/feature/auth/signup_page.dart';
import 'package:facebook_clone/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Facebook',
        home: Wrapper(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryColor),
          //useMaterial3: true,
        ),
      ),
    );
  }
}
