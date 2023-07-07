import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/model/User.dart';
import 'package:tiktokclone/view/screens/auth/login_screen.dart';
import 'package:tiktokclone/view/screens/auth/signup_screen.dart';
import 'package:tiktokclone/view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  //Image picker
  File? profilePicImg;
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final img = File(image.path);
    this.profilePicImg = img;
  }

  // user state persistence
  late Rx<User?> _user;

  User get user => _user.value!;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  // user login
  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Could not log In", "Please try again later");
      }
    } catch (e) {
      Get.snackbar('Error logging in', e.toString());
    }
  }
  // User register

  void signUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String ProfilePicUrl = await _uploadProfilePic(image);

        myUser user = myUser(
            email: email,
            name: username,
            profilePic: ProfilePicUrl,
            uid: credential.user!.uid);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error Creating Account", "Please enter all fields");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occured", e.toString());
    }
  }

  Future<String> _uploadProfilePic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('ProfilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String profilePicUrl = await snapshot.ref.getDownloadURL();

    return profilePicUrl;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginPage());
  }
}
