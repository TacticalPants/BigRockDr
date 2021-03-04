
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_detail.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String string = "TextRecognition";
  File _userImageFile;
  List<ImageLabel> _imageLabels = [];
  String rock = "";
  var result = "";

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  //image_label_recognition
  processImageLabels() async {
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(_userImageFile);
    ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    _imageLabels = await labeler.processImage(myImage);
    result = "";
    for (ImageLabel imageLabel in _imageLabels) {
      setState(() {
        if (imageLabel.text == 'Rock'){
          rock = 'Yo, that\'s a rock!';
        }
        result = result +
            imageLabel.text +
            ":" +
            imageLabel.confidence.toString() +
            "\n";
      });
    }
  }

//recognise_Text
  recogniseText() async {
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(_userImageFile);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);
    result = "";
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        setState(() {
          result = result + ' ' + line.text + '\n';
        });
      }
    }
  }

//drawer_Item
  Widget drawerItem(String title, IconData iconData, String _string) {
    return InkWell(
      onTap: () {
        setState(() {
          string = _string;
        });
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          ListTile(
            leading: Icon(iconData),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.network(
                    "https://1.bp.blogspot.com/-B3K1G5D9sPQ/WvDZJGvkqVI/AAAAAAAAFSc/zx6VYIc0IXQmB8oR4c0i7SKjSNL-2xiTQCLcBGAs/s1600/ml-kit-logo.png"),
              ),
              Divider(),
              drawerItem("Image labeling", Icons.terrain, "ImageLabeling"),
              drawerItem("Text recognition", Icons.title, "TextRecognition"),

            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text(string),
          backgroundColor: Colors.indigo[300],
          actions: [
            IconButton(
              onPressed: () {
                if (string == "TextRecognition") recogniseText();
                if (string == "ImageLabeling") processImageLabels();
              },
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                UserImagePicker(_pickedImage),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(result)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Text(rock),
            color: Colors.indigo[300],

            ),
    );
  }
}