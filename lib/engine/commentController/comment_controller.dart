import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/moulds/comment.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postId = '';
  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _comments.bindStream(firebaseFirestoreInstance
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((event) {
      List<Comment> retLst = [];
      for (var e in event.docs) {
        retLst.add(Comment.fromDocSnapshot(e));
      }
      return retLst;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot documentSnapshot = await firebaseFirestoreInstance
            .collection('users')
            .doc(firebaseAuthController.user.uid)
            .get();

        var allDocs = await firebaseFirestoreInstance
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        int len = allDocs.docs.length;
        var data = documentSnapshot.data() as Map<String, dynamic>;

        Comment comment = Comment(
            comment: commentText.trim(),
            userName: data['userName'],
            profilePicUrl: data['profilePic'],
            uid: data['uid'],
            commentiD: 'Comment$len',
            likes: [],
            dateTime: DateTime.now());
        await firebaseFirestoreInstance
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment$len')
            .set(comment.toJson());

        DocumentSnapshot postDoc = await firebaseFirestoreInstance
            .collection('videos')
            .doc(_postId)
            .get();
        await firebaseFirestoreInstance
            .collection('videos')
            .doc(_postId)
            .update({
          'commentCount':
              (postDoc.data() as Map<String, dynamic>)['commentCount'] + 1
        });
      }
    } catch (e) {
      Get.snackbar('Error commenting', e.toString());
    }
  }

  likeComment(String commentID) async {
    var uid = firebaseAuthController.user.uid;
    DocumentSnapshot snapshot = await firebaseFirestoreInstance
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(commentID)
        .get();

    var data = snapshot.data() as Map<String, dynamic>;
    if (data['likes'].contains(uid)) {
      await firebaseFirestoreInstance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(commentID)
          .update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseFirestoreInstance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(commentID)
          .update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
