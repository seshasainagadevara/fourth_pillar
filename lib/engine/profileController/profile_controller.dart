import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get completeUser => _user.value;
  Rx<String> _uid = ''.obs;
  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    QuerySnapshot myVideos = await firebaseFirestoreInstance
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add(
          (myVideos.docs[i].data() as Map<String, dynamic>)['thumbnailUrl']);
    }

    DocumentSnapshot documentSnapshot = await firebaseFirestoreInstance
        .collection('users')
        .doc(_uid.value)
        .get();

    final data = documentSnapshot.data() as Map<String, dynamic>;
    String name = data['userName'];
    String proPic = data['profilePic'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;
    for (var item in myVideos.docs) {
      likes += ((item.data() as Map<String, dynamic>)['likes'] as List).length;
    }

    var followerDoc = await firebaseFirestoreInstance
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    var followingDoc = await firebaseFirestoreInstance
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    await firebaseFirestoreInstance
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(firebaseAuthController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'userName': name,
      'proPic': proPic,
      'thumbnails': thumbnails
    };
    update();
  }

  followUser() async {
    var doc = await firebaseFirestoreInstance
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(firebaseAuthController.user.uid)
        .get();
    if (!doc.exists) {
      await firebaseFirestoreInstance
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(firebaseAuthController.user.uid)
          .set({});
      await firebaseFirestoreInstance
          .collection('users')
          .doc(firebaseAuthController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value
          .update('followers', (value) => (int.parse(value) + 1).toString());
    } else {
      await firebaseFirestoreInstance
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(firebaseAuthController.user.uid)
          .delete();
      await firebaseFirestoreInstance
          .collection('users')
          .doc(firebaseAuthController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value
          .update('followers', (value) => (int.parse(value) - 1).toString());
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
