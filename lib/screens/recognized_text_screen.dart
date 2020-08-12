import 'package:flutter/material.dart';
import 'package:ocr_detection/models/text_class.dart';

class RecognizedTextScreen extends StatefulWidget {
  List<TextClass> recognizedText;

  RecognizedTextScreen({@required this.recognizedText});

  @override
  _RecognizedTextScreenState createState() => _RecognizedTextScreenState();
}

class _RecognizedTextScreenState extends State<RecognizedTextScreen> {
//  Widget loadingBar() {
//    return CircularProgressIndicator(
//      strokeWidth: 2.0,
//    );
//  }

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

  Widget textTile(word) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      alignment: Alignment.center,
      child: Text(
        word,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TextClass> recText = widget.recognizedText;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recognized Text'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            recText.clear();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: ListView.builder(
              itemCount: recText.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return textTile(recText[index].word);
              },
            ),
//          child: Column(
//            children: <Widget>[
//              Container(
//                height: 500.0,
//                child: Center(child: Text("Hello")),
//              ),
//              Container(
//                height: 500.0,
//                child: Center(child: Text("Hello")),
//              ),
//              Container(
//                height: 500.0,
//                child: Center(child: Text("Hello")),
//              ),
//              Container(
//                height: 500.0,
//                child: Center(child: Text("Hello")),
//              ),
//              Container(
//                height: 500.0,
//                child: Center(child: Text("Hello")),
//              ),
//              Container(
//                height: 500.0,
//                child: Center(child: Text("Hello")),
//              ),
//            ],
//          ),
          ),
        ],
      ),
    );
  }
}

//Container(
//child: ListView.builder(
//itemCount: recText.length,
//itemBuilder: (BuildContext context, int index) {
//return recText[index].word
//? ListTile(
//title: Text(recText[index].word.toString()),
//)
//    : Container();
//},
//),
//),
