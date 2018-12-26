import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatelessWidget {
  CameraScreen() {
    getAvailableCameras();
  }

  getAvailableCameras() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: CameraView());
  }
}

class CameraView extends StatefulWidget {
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  double scale = 1.0; //add this

  _captureImage() {}
  _captureVideo() {}

  Widget _cameraVideoControls() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              onTap: () {
                _captureImage();
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              onTap: () {
                // if (!_toggleCamera) {
                //   onCameraSelected(widget.cameras[1]);
                //   setState(() {
                //     _toggleCamera = true;
                //   });
                // } else {
                //   onCameraSelected(widget.cameras[0]);
                //   setState(() {
                //     _toggleCamera = false;
                //   });
                // }
              },
              child: Icon(
                Icons.video_call,
                color: Colors.white,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _thecamera() {
    return new AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Container(
        child: Stack(
          children: <Widget>[
            GestureDetector(
                onScaleUpdate: (one) {
                  print(one.scale);
                  scale = one.scale;
                  setState(() {});
                },
                child: Transform.scale(
                    scale: scale, child: CameraPreview(controller))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 80.0,
                padding: EdgeInsets.all(20.0),
                color: Color.fromRGBO(00, 00, 00, 0.7),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 26.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          onTap: () {},
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _cameraVideoControls()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return _thecamera();
    // Stack(
    //   alignment: FractionalOffset.center,
    //   children: <Widget>[
    //     new Positioned.fill(
    //       child: new Opacity(
    //         opacity: 0.3,
    //         child: new Image.network(
    //           'https://picsum.photos/3000/4000',
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //     ),
    //     GestureDetector(
    //       onScaleUpdate: (one) {
    //         print(one.scale);
    //         scale = one.scale;
    //         setState(() {});
    //       },
    //       child: Transform.scale(
    //         scale: scale,
    //         child: AspectRatio(
    //             aspectRatio: controller.value.aspectRatio,
    //             child: CameraPreview(controller)),
    //       ),
    //     ),
    //   ],
    // );
  }
}
