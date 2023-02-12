import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/moulds/videoMould.dart';
import 'package:get/get.dart';

class ShowVideosController extends GetxController {
  final Rx<List<VideoMould>> _videosList = Rx<List<VideoMould>>([]);

  List<VideoMould> get getVideosList => _videosList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videosList.bindStream(firebaseFirestoreInstance
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot event) {
      List<VideoMould> lst = [];
      for (var element in event.docs) {
        lst.add(VideoMould.fromSnapshot(element));
      }
      return lst;
    }));
  }

  likeVideo(String videoId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestoreInstance.collection('videos').doc(videoId).get();

    var uid = firebaseAuthController.user.uid;
    var map = documentSnapshot.data() as Map<String, dynamic>;
    if (map['likes'].contains(uid)) {
      await firebaseFirestoreInstance.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseFirestoreInstance.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
