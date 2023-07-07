import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/auth_controller.dart';
import 'package:tiktokclone/controller/profile_controller.dart';
import 'package:tiktokclone/view/widgets/fadeAnimation.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileController.updateUseId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          bool flag = false;
          if (widget.uid == FirebaseAuth.instance.currentUser!.uid)
            flag = true;
          else
            flag = false;
          return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.amber,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${controller.user["name"]}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.snackbar(
                          "TikTok Clone Yt App", "Current Version 1.0");
                    },
                    icon: Icon(Icons.info_outline_rounded),
                  )
                ],
              ),
              body: controller.user.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controller.user['profilePic'],
                                    fit: BoxFit.contain,
                                    height: 120,
                                    width: 120,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['followers'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Followers",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['likes'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Likes",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['following'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Followings",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            FadeAnimation(
                              0.8,
                              InkWell(
                                onTap: () {
                                  if (widget.uid ==
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    authController.signOut();
                                  } else {
                                    controller.followUser();
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: flag
                                          ? const LinearGradient(colors: [
                                              Color(0xFFFD746C),
                                              Color(0xFFFF9068),
                                              Color(0xFFFD746C),
                                            ])
                                          : LinearGradient(colors: [
                                              Colors.blue,
                                              Colors.lightBlue,
                                              Colors.blue,
                                            ])),
                                  child: Center(
                                      child: Text(
                                    widget.uid ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? "Sign Out"
                                        : controller.user['isFollowing']
                                            ? "Following"
                                            : "Follow",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.white,
                              indent: 10,
                              endIndent: 10,
                              thickness: 4,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 5),
                                itemCount: controller.user['thumbnails'].length,
                                itemBuilder: (context, index) {
                                  String thumbnail =
                                      controller.user['thumbnails'][index];
                                  return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: thumbnail,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  );
                                })
                          ],
                        ),
                      ),
                    ));
        });
  }
}
