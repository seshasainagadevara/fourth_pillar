import 'package:cloud_firestore/cloud_firestore.dart';

class FUser {
  final String userName;
  final String email;
  final String uid;
  final String? profilePic;

  FUser(
      {required this.userName,
      required this.email,
      required this.uid,
      required this.profilePic});

  factory FUser.getUserFromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? doc = snapshot.data() as Map<String, dynamic>;
    return FUser(
        userName: doc['userName'] ?? '',
        email: doc['email'] ?? '',
        uid: doc['uid'] ?? '',
        profilePic: doc['profilePic'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'uid': uid,
      'profilePic': profilePic ?? ''
    };
  }
}
