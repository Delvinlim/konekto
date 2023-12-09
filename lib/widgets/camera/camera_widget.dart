/// CameraScreen.dart
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({required this.cameras, super.key});
  final List<CameraDescription> cameras;

  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  late Future<void> cameraValue;

  @override
  void initState() {
    super.initState();
    // print(widget.cameras[0])
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.veryHigh);
    try {
      cameraValue = _cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _cameraController = CameraController(widget.cameras[0], ResolutionPreset.max);
  //   cameraValue = _cameraController.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           // Handle access errors here.
  //           break;
  //         default:
  //           // Handle other errors here.
  //           break;
  //       }
  //     }
  // });

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController cameraController = _cameraController;

  //   // App state changed before we got the chance to initialize.
  //   if (!cameraController.value.isInitialized) {
  //     return;
  //   }

  //   if (state == AppLifecycleState.inactive) {
  //     cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     _initializeCameraController(cameraController.description);
  //   }
  // }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 2),
    ));
  }

  void _logError(String code, String? message) {
    // ignore: avoid_print
    print('Error: $code${message == null ? '' : '\nError Message: $message'}');
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  // Future<void> _initializeCameraController(
  //     CameraDescription cameraDescription) async {
  //   final CameraController cameraController = CameraController(
  //     cameraDescription,
  //     ResolutionPreset.max,
  //     imageFormatGroup: ImageFormatGroup.jpeg,
  //   );

  //   // _cameraController =
  //   //     CameraController(widget.cameras[0], ResolutionPreset.max);

  //   _cameraController = cameraController;

  //   // If the controller is updated then update the UI.
  //   cameraController.addListener(() {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     if (cameraController.value.hasError) {
  //       showInSnackBar(
  //           'Camera error ${cameraController.value.errorDescription}');
  //     }
  //   });

  //   try {
  //     await cameraController.initialize();
  //   } on CameraException catch (e) {
  //     switch (e.code) {
  //       case 'CameraAccessDenied':
  //         showInSnackBar('You have denied camera access.');
  //         break;
  //       case 'CameraAccessDeniedWithoutPrompt':
  //         // iOS only
  //         showInSnackBar('Please go to Settings app to enable camera access.');
  //         break;
  //       case 'CameraAccessRestricted':
  //         // iOS only
  //         showInSnackBar('Camera access is restricted.');
  //         break;
  //       case 'AudioAccessDenied':
  //         showInSnackBar('You have denied audio access.');
  //         break;
  //       case 'AudioAccessDeniedWithoutPrompt':
  //         // iOS only
  //         showInSnackBar('Please go to Settings app to enable audio access.');
  //         break;
  //       case 'AudioAccessRestricted':
  //         // iOS only
  //         showInSnackBar('Audio access is restricted.');
  //         break;
  //       default:
  //         _showCameraException(e);
  //         break;
  //     }
  //   }

  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                // ignore: avoid_print
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: size.width,
                    height: size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                          width: 100, // the actual width is not important here
                          child: CameraPreview(_cameraController)),
                    ),
                  );
                  // return CameraPreview(_cameraController);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          // CupertinoButton(
          //   onPressed: () async {
          //     // Take the Picture in a try / catch block. If anything goes wrong,
          //     // catch the error.
          //     try {
          //       // Ensure that the camera is initialized.
          //       await cameraValue;

          //       // Attempt to take a picture and get the file `image`
          //       // where it was saved.
          //       final image = await _cameraController.takePicture();

          //       if (!mounted) return;

          //       // If the picture was taken, display it on a new screen.
          //       await Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => DisplayPictureScreen(
          //             // Pass the automatically generated path to
          //             // the DisplayPictureScreen widget.
          //             imagePath: image.path,
          //           ),
          //         ),
          //       );
          //     } catch (e) {
          //       // If an error occurs, log the error to the console.
          //       print(e);
          //     }
          //   },
          //   child: const Icon(
          //     Icons.camera_alt,
          //     color: Colors.black,
          //     size: 36,
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await cameraValue;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _cameraController.takePicture();

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        backgroundColor: CupertinoColors.white,
        child: const Icon(
          Icons.camera_alt,
          color: CupertinoColors.black,
          size: 36,
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
            width: 100, // the actual width is not important here
            child: Image.file(File(imagePath))),
      ),
    ));
  }
}
