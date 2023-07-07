import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/auth_controller.dart';
import 'package:tiktokclone/view/screens/auth/login_screen.dart';
import 'package:tiktokclone/view/widgets/fadeAnimation.dart';
import 'package:tiktokclone/view/widgets/textField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _image = true;
  @override
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfController = TextEditingController();
  Widget build(BuildContext context) {
    // String name = '';
    // String email = '';
    // String password = '';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Column(children: [
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  AuthController.instance.pickImage();
                },
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage:
                          NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                      backgroundColor: Colors.red,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
              ),
              FadeAnimation(
                  1.6,
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
              FadeAnimation(
                  1.8,
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 20,
                              offset: Offset(0, 5))
                        ]),
                    child: Column(children: [
                      textField(
                          name: "Username",
                          controller: usernameController,
                          obscureText: false),
                      SizedBox(
                        height: 10,
                      ),
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
                        height: 10,
                      ),
                      textField(
                          name: "Confiem Password",
                          controller: cnfController,
                          obscureText: true),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          TextButton(
                            onPressed: () async {
                              AuthController.instance.signUp(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  AuthController.instance.profilePicImg);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFFD746C),
                                  Color(0xFFFF9068),
                                  Color(0xFFFD746C),
                                ]),
                              ),
                              child: Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Already have an account ?",
                            style: TextStyle(color: Colors.white),
                          )),
                      FadeAnimation(
                          2.2,
                          TextButton(
                            onPressed: () {
                              Get.offAll(LoginPage());
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
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                    ]),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Widget MyTextField(
      String name, TextEditingController controller, bool obsecureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
