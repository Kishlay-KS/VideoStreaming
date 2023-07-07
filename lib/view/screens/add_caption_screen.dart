// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:tiktokclone/controller/upload_video_controller.dart';
// import 'package:tiktokclone/view/widgets/textField.dart';
// import 'package:video_player/video_player.dart';

// class addCaption_Screen extends StatefulWidget {
//   File videoFile;
//   String videoPath;

//   addCaption_Screen(
//       {Key? key, required this.videoFile, required this.videoPath})
//       : super(key: key);

//   @override
//   State<addCaption_Screen> createState() => _addCaption_ScreenState();
// }

// class _addCaption_ScreenState extends State<addCaption_Screen> {
//   late VideoPlayerController videoPlayerController;

//   VideoUploadController videoUploadController =
//       Get.put(VideoUploadController());
//   TextEditingController songNameController = new TextEditingController();
//   TextEditingController captionController = new TextEditingController();

//   Widget UploadContent = Text("Upload");

//   uploadVid() {
//     UploadContent = Text("Please Wait..");
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     videoPlayerController.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       videoPlayerController = VideoPlayerController.file(widget.videoFile);
//     });
//     videoPlayerController.initialize();
//     videoPlayerController.play();
//     videoPlayerController.setLooping(true);
//     videoPlayerController.setVolume(0.7);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 1.4,
//               child: VideoPlayer(videoPlayerController),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 4,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
// textField(
//     name: 'Song Name',
//     controller: songNameController,
//     obscureText: false),
// SizedBox(
//   height: 20,
// ),
// textField(
//     name: "Caption",
//     controller: captionController,
//     obscureText: false),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       uploadVid();
//                       videoUploadController.uploadVideo(songNameController.text,
//                           captionController.text, widget.videoPath);
//                     },
//                     child: Text('upload'),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/upload_video_controller.dart';
import 'package:tiktokclone/view/widgets/textField.dart';
import 'package:video_player/video_player.dart';

class addCaption_Screen extends StatefulWidget {
  File videoFile;
  String videoPath;

  addCaption_Screen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<addCaption_Screen> createState() => _addCaption_ScreenState();
}

class _addCaption_ScreenState extends State<addCaption_Screen> {
  late VideoPlayerController videoPlayerController;

  final videoUploadController = Get.put(VideoUploadController());

  TextEditingController songNameController = new TextEditingController();
  TextEditingController captionController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textField(
                      name: 'Song Name',
                      controller: songNameController,
                      obscureText: false),
                  SizedBox(
                    height: 20,
                  ),
                  textField(
                      name: "Caption",
                      controller: captionController,
                      obscureText: false),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await videoUploadController.uploadVideo(
                          songNameController.text,
                          captionController.text,
                          widget.videoPath);
                      Get.snackbar(
                          'Video uploaded', 'Thanks for sharing your content');
                    },
                    child: Text("Upload"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
