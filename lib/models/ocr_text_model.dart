import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

// ignore: missing_return
Future<VisionText> getOCRText(File pickedImage) async {
  try {
    FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText =
        await textRecognizer.processImage(firebaseVisionImage);

    return readText;
  } catch (e) {
    print('Not Working...');
  }
}
