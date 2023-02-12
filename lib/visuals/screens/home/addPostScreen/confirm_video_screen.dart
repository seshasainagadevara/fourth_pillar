import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fourth_pillar/engine/videoController/video_upload_controller.dart';
import 'package:fourth_pillar/visuals/parts/text_input_field.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmVideoScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends State<ConfirmVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final VideoUplaodController _videoUplaodController =
      Get.put<VideoUplaodController>(VideoUplaodController());

  @override
  void initState() {
    super.initState();

    setState(() {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setVolume(1.0);
    _videoPlayerController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(_videoPlayerController),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      textEditingController: _songController,
                      label: 'Song name',
                      icon: Icons.music_note_outlined,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      textEditingController: _captionController,
                      label: 'Caption it',
                      icon: Icons.closed_caption_outlined,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _videoUplaodController.uploadVideo(_songController.text,
                            _captionController.text, widget.videoPath);
                      },
                      child: const Text(
                        'Share',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _songController.dispose();
    _captionController.dispose();
    super.dispose();
  }
}
