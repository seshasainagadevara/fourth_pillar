import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String comment;
  final String userName;
  final String profilePicUrl;
  final String uid;
  final String commentiD;
  final List likes;
  final DateTime dateTime;

  Comment(
      {required this.comment,
      required this.userName,
      required this.profilePicUrl,
      required this.uid,
      required this.commentiD,
      required this.likes,
      required this.dateTime});

  factory Comment.fromDocSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    return Comment(
      comment: map['comment'],
      userName: map['userName'],
      profilePicUrl: map['profilePicUrl'],
      uid: map['uid'],
      commentiD: map['commentiD'],
      likes: map['likes'],
      dateTime: (map['dateTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'userName': userName,
      'profilePicUrl': profilePicUrl,
      'uid': uid,
      'commentiD': commentiD,
      'likes': likes,
      'dateTime': dateTime
    };
  }
}
