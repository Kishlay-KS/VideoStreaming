import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/auth_controller.dart';
import 'package:tiktokclone/model/Video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance
        .collection('Videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var elem in query.docs) {
        retVal.add(Video.fromSnap(elem));
      }
      return retVal;
    }));
  }

  likedVideo(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Videos").doc(id).get();
    var uid = AuthController.instance.user.uid;

    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection('Videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection('Videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
