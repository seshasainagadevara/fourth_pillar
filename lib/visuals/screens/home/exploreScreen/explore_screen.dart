import 'package:flutter/material.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/engine/videoController/show_videos_controller.dart';
import 'package:fourth_pillar/moulds/videoMould.dart';
import 'package:fourth_pillar/visuals/parts/disc_rotation_animation_widget.dart';
import 'package:fourth_pillar/visuals/parts/video_widget.dart';
import 'package:fourth_pillar/visuals/screens/home/commentsScreen/comments_likes_screen.dart';
import 'package:get/get.dart';

class ExploreVideoScreen extends StatefulWidget {
  const ExploreVideoScreen({Key? key}) : super(key: key);

  @override
  State<ExploreVideoScreen> createState() => _ExploreVideoScreenState();
}

class _ExploreVideoScreenState extends State<ExploreVideoScreen> {
  final PageController _pageViewController = PageController();
  late final ShowVideosController _showVideosController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showVideosController =
        Get.put<ShowVideosController>(ShowVideosController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(
          () => PageView.builder(
              itemCount: _showVideosController.getVideosList.length,
              scrollDirection: Axis.vertical,
              controller: _pageViewController,
              itemBuilder: (context, index) {
                final VideoMould videoItem =
                    _showVideosController.getVideosList[index];
                return Stack(
                  children: [
                    VideoWidget(videoUrl: videoItem.videoUrl),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      _getProfileFollowIcon(
                                          videoItem.profilePic),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () => _showVideosController
                                                .likeVideo(videoItem.videoId),
                                            child: videoItem.likes.contains(
                                                    firebaseAuthController
                                                        .user.uid)
                                                ? const Icon(
                                                    Icons.favorite,
                                                    size: 40,
                                                    color: Colors.redAccent,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .favorite_outline_outlined,
                                                    size: 40,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            videoItem.likes.length.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () =>
                                                Get.to(() => CommentsScreen(
                                                      videoId:
                                                          videoItem.videoId,
                                                    )),
                                            child: const Icon(
                                              Icons.comment,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            videoItem.commentCount.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.share,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            videoItem.shareCount.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    videoItem.userName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    videoItem.caption,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 18,
                                      ),
                                      Text(
                                        videoItem.songName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              DiscRotationAnimation(
                                  child:
                                      _circularProfile(videoItem.thumbnailUrl)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      _pageViewController.dispose();
    }

    super.dispose();
  }

  Widget _getProfileFollowIcon(String profilePicUrl) {
    return Container(
      height: 70,
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 50,
            // padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image(
                  image: NetworkImage(
                    profilePicUrl,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Container(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryColor,
                    ),
                    alignment: Alignment.center,
                    width: 15,
                    height: 15,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _circularProfile(String profilePicUrl) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [Colors.grey, Colors.white]),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePicUrl),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
