import 'package:cloud_firestore/cloud_firestore.dart';

class VideoMould {
  final String userName;
  final String uid;
  final String videoId;
  final List likes;
  final int commentCount;
  final int shareCount;
  final String songName;
  final String caption;
  final String videoUrl;
  final String thumbnailUrl;
  final String profilePic;

  VideoMould(
      {required this.userName,
      required this.uid,
      required this.videoId,
      required this.likes,
      required this.commentCount,
      required this.shareCount,
      required this.songName,
      required this.caption,
      required this.videoUrl,
      required this.thumbnailUrl,
      required this.profilePic});
  factory VideoMould.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return VideoMould(
        userName: map['userName'],
        uid: map['uid'],
        videoId: map['videoId'],
        likes: map['likes'],
        commentCount: map['commentCount'],
        shareCount: map['shareCount'],
        songName: map['songName'],
        caption: map['caption'],
        videoUrl: map['videoUrl'],
        thumbnailUrl: map['thumbnailUrl'],
        profilePic: map['profilePic']);
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'uid': uid,
      'videoId': videoId,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'profilePic': profilePic
    };
  }
}
