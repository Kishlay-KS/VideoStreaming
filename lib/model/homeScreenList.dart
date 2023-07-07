import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/view/screens/add_video.dart';
import 'package:tiktokclone/view/screens/display_video_screen.dart';
import 'package:tiktokclone/view/screens/profile_screen.dart';
import 'package:tiktokclone/view/screens/search_screen.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
var homeScreenList = [
  DisplayVideo_Screen(),
  SearchScreen(),
  addVideoScreen(),
  Text('Messages'),
  ProfileScreen(uid: uid),
];
