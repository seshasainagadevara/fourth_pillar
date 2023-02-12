import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/engine/profileController/profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => _profileController.completeUser.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black12,
                leading: const Icon(Icons.person_add_alt_1_outlined),
                actions: const [Icon(Icons.more_horiz)],
                title: Text(
                  _profileController.completeUser['userName'] ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 80,
                      backgroundColor: Colors.deepPurpleAccent,
                      backgroundImage: NetworkImage(
                          _profileController.completeUser['proPic']),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _getColumn(
                            'Following',
                            _profileController.completeUser['following'] ??
                                '0'),
                        _getColumn(
                            'Followers',
                            _profileController.completeUser['followers'] ??
                                '0'),
                        _getColumn('Likes',
                            _profileController.completeUser['likes'] ?? '0'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: TextButton(
                        onPressed: () {
                          if (widget.uid == firebaseAuthController.user.uid) {
                            firebaseAuthController.signout();
                          } else {
                            _profileController.followUser();
                          }
                        },
                        child: Text(
                          widget.uid == firebaseAuthController.user.uid
                              ? 'Signout'
                              : _profileController.completeUser['isFollowing']
                                  ? 'Unfollow'
                                  : 'Follow',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10),
                                itemCount: _profileController
                                    .completeUser['thumbnails'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _profileController.completeUser[
                                                    'thumbnails'][index]))),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _getColumn(String title, String count) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(count,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17)),
        const SizedBox(
          height: 10.0,
        ),
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14)),
      ]),
    );
  }
}
