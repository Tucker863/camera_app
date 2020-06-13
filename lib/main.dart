import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/second': (context) => ImageScreen(),
      '/third': (context) => VideoScreen(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera utilization'),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image(image: new AssetImage("assets/logo.gif")),
            new RaisedButton(
              child: Text('Take a picture'),
              elevation: 5.0,
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/second');
              },
            ),
            new RaisedButton(
              child: Text('Take a video'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/third');
              },
            ),
            new Text(
                "Ready to use camera"
            ),
          ],
        ),
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen>{

  File _cameraImage;

  _pickImageFromCamera() async {
    File image = await  ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _cameraImage = image;
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
              padding: const EdgeInsets.all(10.0),child: Text('Sun Shine'))
        ],

      ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: <Widget>[
                      if(_cameraImage != null)
                        Image.file(_cameraImage)
                      else
                        Text("Take a picture", style: TextStyle(fontSize: 18.0),),
                      RaisedButton(
                        onPressed: () {
                          _pickImageFromCamera();
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
                    ]
                )
            )
        )
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>{

  File _cameraVideo;

  VideoPlayerController _cameraVideoPlayerController;

  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
    _cameraVideo = video;
    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
      setState(() { });
      _cameraVideoPlayerController.play();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Screen"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: <Widget>[

                      if(_cameraVideo != null)
                        _cameraVideoPlayerController.value.initialized
                            ? AspectRatio(
                          aspectRatio: _cameraVideoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_cameraVideoPlayerController),
                        )
                            : Container()
                      else
                        Text("Take a video", style: TextStyle(fontSize: 18.0),),
                      RaisedButton(
                        onPressed: () {
                          _pickVideoFromCamera();
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
                    ]
                )
            )
        )
      ),
    );
  }
}