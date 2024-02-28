import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class CaptureImage {
  static Future<void> captureAndDisplayImage(BuildContext context, String userEmail) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    final controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    try {
      await controller.initialize();
      final XFile imageFile = await controller.takePicture();

      // Save the image to local storage
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String imagePath = '${appDirectory.path}/$userEmail.jpg';
      final File localImageFile = await File(imageFile.path).copy(imagePath);

      // Display the captured image
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Captured Image'),
            content: Image.file(localImageFile),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error capturing image: $e');
    } finally {
      await controller.dispose(); // Dispose the camera controller
    }
  }
}
