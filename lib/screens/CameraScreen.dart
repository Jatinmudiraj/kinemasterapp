import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/screens/editScreen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String PictureButtonText = "Take a Picture";
  String VideoButtonText = "Record video";

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                backgroundColor: ShadowColor,
                onPressed: _takePhoto,
                label: Text('Take a Photo'),
              ),
              SizedBox(
                width: 50,
              ),
              FloatingActionButton.extended(
                backgroundColor: ShadowColor,
                onPressed: _recordVideo,
                label: Text('Record a Video'),
              ),
            ]),
      ),
    );
  }

  void _takePhoto() async {
    ImagePicker()
        .getImage(source: ImageSource.camera)
        .then((PickedFile recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        setState(() {
          PictureButtonText = "Saving in progress...";
        });
        GallerySaver.saveImage(recordedImage.path, albumName: "TestImage");
      }
    });
  }

  void _pickVideo() async {
    final XFile file = await _picker.pickVideo(source: ImageSource.gallery);

    if (mounted && file != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditScreen(file: File(file.path)),
        ),
      );
    }
  }

  void _recordVideo() async {
    ImagePicker()
        .getVideo(source: ImageSource.camera)
        .then((PickedFile recordedVideo) {
      if (recordedVideo != null && recordedVideo.path != null) {
        setState(() {
          VideoButtonText = "Saving Video...";
        });
        GallerySaver.saveVideo(recordedVideo.path, albumName: "TestVideo");
            
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: 'Video Saved Successfully'
            );

        _pickVideo();
      }
    });
  }
}
