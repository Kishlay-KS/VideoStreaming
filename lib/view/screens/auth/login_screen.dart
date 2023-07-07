import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/auth_controller.dart';
import 'package:tiktokclone/view/screens/auth/signup_screen.dart';
import 'package:tiktokclone/view/widgets/fadeAnimation.dart';
import 'package:tiktokclone/view/widgets/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              FadeAnimation(
                  1.6,
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(children: [
                  FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black45!,
                                  blurRadius: 20,
                                  offset: Offset(0, 5))
                            ]),
                        child: Column(children: [
                          textField(
                              name: "Email",
                              controller: emailController,
                              obscureText: false),
                          SizedBox(
                            height: 10,
                          ),
                          textField(
                              name: "Password",
                              controller: passwordController,
                              obscureText: true),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                              2,
                              TextButton(
                                onPressed: () async {
                                  AuthController.instance.login(
                                      emailController.text,
                                      passwordController.text);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFFD746C),
                                        Color(0xFFFF9068),
                                        Color(0xFFFD746C),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                          Text(
                            "Dont have an account ?",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                              2.2,
                              TextButton(
                                onPressed: () {
                                  Get.offAll(SignUp());
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFFD746C),
                                        Color(0xFFFF9068),
                                        Color(0xFFFD746C),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                              1.5,
                              Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.white),
                              )),
                        ]),
                      )),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
