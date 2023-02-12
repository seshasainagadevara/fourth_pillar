import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/moulds/videoMould.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class VideoUplaodController extends GetxController {
  Future<String> _uploadVideoToFirebase(String id, String videoPath) async {
    Reference ref = firebaseStorageInstance.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile((await _compressVideo(videoPath))!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File?> _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoThumbnail(String id, String videoPath) async {
    Reference ref = firebaseStorageInstance.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

//upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuthInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firebaseFirestoreInstance.collection('users').doc(uid).get();
      Map<String, dynamic> usrDoc =
          documentSnapshot.data() as Map<String, dynamic>;

      var allDocs = await firebaseFirestoreInstance.collection('videos').get();
      int length = allDocs.docs.length;
      String downloadUrl =
          await _uploadVideoToFirebase("videos $length", videoPath);

      String thumbnailUrl =
          await _uploadVideoThumbnail("videos $length", videoPath);
      VideoMould videoMould = VideoMould(
          userName: usrDoc['userName'],
          uid: uid,
          videoId: 'videos $length',
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: downloadUrl,
          thumbnailUrl: thumbnailUrl,
          profilePic: usrDoc['profilePic']);
      await firebaseFirestoreInstance
          .collection('videos')
          .doc('videos $length')
          .set(videoMould.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('Video upload failed !', e.toString());
    }
  }
}
