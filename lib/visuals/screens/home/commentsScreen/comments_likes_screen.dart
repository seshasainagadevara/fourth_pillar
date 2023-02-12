import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/engine/commentController/comment_controller.dart';
import 'package:fourth_pillar/moulds/comment.dart';
import 'package:fourth_pillar/visuals/parts/comment_widget.dart';
import 'package:fourth_pillar/visuals/parts/text_input_field.dart';
import 'package:get/get.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({Key? key, required this.videoId}) : super(key: key);
  final String videoId;
  final TextEditingController _commentTextEditingController =
      TextEditingController();
  final CommentController _commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    _commentController.updatePostId(videoId);
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: _commentController.comments.length,
              itemBuilder: (context, index) {
                Comment comment = _commentController.comments[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommentWidget(
                        userName: comment.userName,
                        comment: comment.comment,
                        profilePicUrl: comment.profilePicUrl,
                        duration: DateTime.now()
                                    .difference(comment.dateTime)
                                    .inDays >
                                31
                            ? "${((DateTime.now().difference(comment.dateTime).inDays) ~/ 30).toString()} months"
                            : "${DateTime.now().difference(comment.dateTime).inDays.toString()} days",
                        likes: comment.likes.length.toString(),
                        id: comment.commentiD,
                        likeIt: comment.likes
                            .contains(firebaseAuthController.user.uid)),
                    Divider(
                      height: 2.0,
                      color: teritaryColor.withOpacity(0.5),
                    )
                  ],
                );
              },
            ),
          )),
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _commentTextEditingController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  // maxLines: 10,

                  decoration: InputDecoration(
                    hintText: 'Comment',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                )),
                TextButton(
                    onPressed: () {
                      _commentController
                          .postComment(_commentTextEditingController.text);
                      _commentTextEditingController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
