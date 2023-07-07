import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/model/Post.dart';
import 'package:uuid/uuid.dart';

class UploadPostController extends GetxController {
  // Upload Image to Storage
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid);
    String id = const Uuid().v1();
    ref = ref.child(id);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Upload Post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "success";
    try {
      String photoUrl = await uploadImageToStorage('Posts', file);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          datePublished: DateTime.now(),
          postId: postId,
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .set(post.toJson());

      Get.snackbar("Success", "Successfully Uploaded");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    return res;
  }

  //Delete post
  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance.collection('Posts').doc(postId).delete();
      Get.snackbar("Deleted", "Successfully deleted post");
    } catch (e) {
      Get.snackbar("Error orrured", e.toString());
    }
  }

  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occured";
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await FirebaseFirestore.instance
            .collection('Posts')
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = "success";
        Get.snackbar("Success", "Commented successfully");
      } else {
        print('Text is empty');
        Get.snackbar("Error", "Please add comment");
        res = "Please enter comment";
      }
    } catch (e) {
      res = "Cannot add comment";
      Get.snackbar("Error", e.toString());
      print(e.toString());
    }
    return res;
  }

  //Liking
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await FirebaseFirestore.instance
            .collection('Posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
}
