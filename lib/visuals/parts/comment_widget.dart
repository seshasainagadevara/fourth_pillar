import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/engine/commentController/comment_controller.dart';
import 'package:get/get.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {Key? key,
      required this.userName,
      required this.comment,
      required this.profilePicUrl,
      required this.duration,
      required this.likes,
      required this.id,
      required this.likeIt})
      : super(key: key);
  final String userName;
  final String comment;
  final String profilePicUrl;
  final String duration;
  final String likes;
  final String id;
  final bool likeIt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              userName,
              style: TextStyle(color: secondaryColor, fontSize: 14.0),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              comment,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ],
      ),
      leading: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              profilePicUrl,
              fit: BoxFit.fill,
            ),
          )),
      trailing: IconButton(
        onPressed: () {
          Get.find<CommentController>().likeComment(id);
        },
        icon: Icon(
          likeIt ? Icons.favorite : Icons.favorite_outline,
          color: Colors.red,
        ),
      ),
      subtitle: Row(
        children: [
          Text("${duration} ago"),
          const SizedBox(
            width: 10.0,
          ),
          Text("${likes} likes"),
        ],
      ),
    );
  }
}
