import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/visuals/parts/custom_icon.dart';
import 'package:fourth_pillar/visuals/screens/home/addPostScreen/confirm_video_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline_rounded,
                size: 40.0,
                color: Colors.white54,
              ),
              const SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  showOptionsDialog(context);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Text(
                    'Add video',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    _pickVideo(ImageSource.gallery, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    _pickVideo(ImageSource.camera, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.close),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  void _pickVideo(ImageSource src, BuildContext context) async {
    final pickedVideo = await ImagePicker().pickVideo(
      source: src,
    );
    if (pickedVideo != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ConfirmVideoScreen(
                videoFile: File(pickedVideo.path),
                videoPath: pickedVideo.path,
              )));
    }
  }
}
