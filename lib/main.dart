import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/auth_controller.dart';
import 'package:tiktokclone/firebase_options.dart';
import 'package:tiktokclone/view/screens/auth/login_screen.dart';
import 'package:tiktokclone/view/screens/auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Go Crazy',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: LoginPage(),
    );
  }
}
