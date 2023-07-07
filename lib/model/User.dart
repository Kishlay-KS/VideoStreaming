import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  String email;
  String profilePic;
  String uid;

  myUser(
      {required this.email,
      required this.name,
      required this.profilePic,
      required this.uid});

  // json to map

  Map<String, dynamic> toJson() {
    return {"name": name, "profilePic": profilePic, "email": email, "uid": uid};
  }

  // Firebase snap to user model

  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return myUser(
        email: snapshot['email'],
        name: snapshot['name'],
        profilePic: snapshot['profilePic'],
        uid: snapshot['uid']);
  }
}
