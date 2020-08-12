import 'package:flutter/material.dart';
import 'package:ocr_detection/models/text_class.dart';

class TextFieldScreen extends StatefulWidget {
  final List<TextClass> detectedList;
  TextFieldScreen({this.detectedList});
  @override
  _TextFieldScreenState createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  final textController = TextEditingController();
  String sentence = '';
  bool isSentence = false;

//  Widget getListItems() {
//    myList.forEach((element) {
//      sentence = sentence + element + ' ';
//    });
//    return Text(sentence);
//  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TextClass> myList = widget.detectedList;

    void buttonPressed() {
      for (TextClass element in myList) {
        sentence += element.word + ' ';
      }
      setState(() {
        textController.text = sentence;
        isSentence = true;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Text Detected'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              myList.clear();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
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
                child: isSentence
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: Text(
                            sentence,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              wordSpacing: 1.0,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text('Click It.'),
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  controller: textController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              RaisedButton(
                child: Text(
                  'Get it',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: buttonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
