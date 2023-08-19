import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/screens/editScreen.dart';

class VideoEditorExample extends StatefulWidget {
  const VideoEditorExample({key});

  @override
  State<VideoEditorExample> createState() => _VideoEditorExampleState();
}

class _VideoEditorExampleState extends State<VideoEditorExample> {
  String PictureButtonText = "Take a Picture";
  String VideoButtonText = "Record video";

  final ImagePicker _picker = ImagePicker();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Let's get started",style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20,),
                Text('Choose media from Gallery', style: TextStyle(color: Colors.white, fontSize: 15),),
          const SizedBox(height: 20.0,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  FloatingActionButton.extended(
                    backgroundColor: ButtonColor,
                    onPressed: _takePhoto,
                    label: Text('Take a Photo'),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: ButtonColor,
                    onPressed: _recordVideo,
                    label: Text('Record a Video'),
                  ),
                  
                ]),
                SizedBox(height: 20,),
                Text('Choose media from Gallery', style: TextStyle(color: Colors.white, fontSize: 15),),
                SizedBox(height: 20,),
                FloatingActionButton.extended(
                    backgroundColor: ButtonColor,
                    onPressed: _pickVideo,
                    label: Text('Pick a video'),
                  ),
          ],
        ),
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



}