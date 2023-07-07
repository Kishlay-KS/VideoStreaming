import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/model/User.dart';

class mySearchController extends GetxController {
  final Rx<List<myUser>> _searchmyUser = Rx<List<myUser>>([]);

  List<myUser> get searchList => _searchmyUser.value;

  searchmyUserFunction(String query) async {
    _searchmyUser.bindStream(FirebaseFirestore.instance
        .collection('Users')
        .where('name', isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((QuerySnapshot snap) {
      List<myUser> retVal = [];
      for (var elem in snap.docs) {
        retVal.add(myUser.fromSnap(elem));
      }
      return retVal;
    }));
  }
}
