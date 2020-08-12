import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_detection/models/text_class.dart';
import 'package:ocr_detection/screens/textfield_screen.dart';
import 'models/ocr_text_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR Detection',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('OCR Detection'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  final picker = ImagePicker();
  bool isImageLoaded = false;
  List<TextClass> textList = List();

  Future pickImageFromDevice(int type) async {
    PickedFile tempPickedImage = await picker.getImage(
        source: type == 1 ? ImageSource.gallery : ImageSource.camera);
    if (mounted) {
      setState(() {
        pickedImage = File(tempPickedImage.path);
        isImageLoaded = true;
//        print("It Works though");
      });
    }
  }
//  Future pickImageFromGallery() async {
//    PickedFile tempPickedImage =
//        await picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      pickedImage = File(tempPickedImage.path);
//      isImageLoaded = true;
//    });
//  }
//
//  Future pickImageFromCamera() async {
//    final tempPickedImage = await picker.getImage(source: ImageSource.camera);
//
//    setState(() {
//      pickedImage = File(tempPickedImage.path);
//      isImageLoaded = true;
//    });
//  }

  Future readText() async {
    try {
//      FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(pickedImage);
//      TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//      VisionText readText = await textRecognizer.processImage(firebaseVisionImage);

      final readText = await getOCRText(pickedImage);

      for (TextBlock block in readText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement word in line.elements) {
            print(word.text);
            final temp = getTextClass(word.text);
            textList.add(temp);
          }
        }
      }
      print(textList[0].word);
    } catch (e) {
      print(e);
      print('Not Working');
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextFieldScreen(
          detectedList: textList,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            height: 350.0,
            width: 250.0,
            child: isImageLoaded
                ? Image.file(
                    pickedImage,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Text(
                      'Oops! Image not Loaded',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  pickImageFromDevice(1);
                },
                child: Text(
                  "Pick Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Use Camera',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  pickImageFromDevice(2);
                },
              ),
              SizedBox(
                width: 5.0,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Read Image',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: readText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
