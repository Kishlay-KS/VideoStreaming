import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/model/Video.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
  // VideoUploadController instance = Get.find();
  var uuid = Uuid();

  // generate thumbnail

  Future<File> getThumb(String videoPath) {
    final thumb = VideoCompress.getFileThumbnail(videoPath);

    return thumb;
  }

  // upload thumbnail to storage

  Future<String> _uploadVideoThumbnailToStorage(
      String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('Thumbnail').child(id);
    UploadTask uploadTask = ref.putFile(await getThumb(videoPath));

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Upload main video ans thumbnail to storage
  showSnak() {
    Get.snackbar('Success', 'Congrats');
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      //video ID
      String id = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id, videoPath);
      String thumbnail = await _uploadVideoThumbnailToStorage(id, videoPath);

      Video video = Video(
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          thumbnail: thumbnail,
          caption: caption,
          commentsCount: 0,
          id: id,
          likes: [],
          profilePic: (userDoc.data()! as Map<String, dynamic>)['profilePic'],
          shareCount: 0,
          songName: songName,
          videoUrl: videoUrl);
      await FirebaseFirestore.instance
          .collection('Videos')
          .doc(id)
          .set(video.toJson());
      // showSnak();
      Get.back();
    } catch (e) {
      print(e.toString());
      Get.snackbar("Unable to upload video", "Please try again later");
    }
  }

  // Upload main video to storage

  Future<String> _uploadVideoToStorage(String videoId, String videoPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('Videos').child(videoId);
    UploadTask uploadTask =
        ref.putFile(await _compressedVideo(videoPath) as File);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  // compress main video

  Future<File?> _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);

    return compressedVideo!.file;
  }
}
