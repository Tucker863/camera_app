import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String firstButtonText = 'Take photo';
  File _image;
  File _cameraImage;

  _pickImageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _pickImageFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _cameraImage = image;
    });
  }

  void _takePhoto() async {
    ImagePicker.pickImage(source: ImageSource.camera)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        setState(() {
          firstButtonText = 'saving in progress...';
        });
        GallerySaver.saveImage(recordedImage.path, albumName: 'Gallery')
            .then((bool success) {
          setState(() {
            firstButtonText = 'image saved to Gallery';
            _cameraImage = recordedImage;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logov1.jpg',
              fit: BoxFit.contain,
              height: 56,
            ),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Sun Shine'))
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    if (_image != null)
                      Image.file(_image)
                    else
                      Text(
                        firstButtonText,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    RaisedButton(
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                      child: Text("Pick Image From Gallery"),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    if (_cameraImage != null)
                      Image.file(_cameraImage)
                    else
                      Text(
                        "Take a picture",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    RaisedButton(
                      onPressed: () {
                        _takePhoto();
                      },
                      child: new Icon(
                        Icons.add,
                        size: 36.0,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // Navigate back to the first screen by popping the current route
                        // off the stack.
                        Navigator.pop(context);
                      },
                      child: Text('Go back!'),
                    ),
                  ])))),
    );
  }
}
