import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';

class FeedbackForm extends StatefulWidget {
  FeedbackForm({Key key}) : super(key: key);

  @override
  FeedbackState createState() => FeedbackState();
}

class FeedbackState extends State<FeedbackForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.arrow_back,
                  color: Constants.blackColor,
                ),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Feedback",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              "https://docs.google.com/forms/d/e/1FAIpQLSeD5kYUdc-lDTlqhrezl0v1E6q-n8j3aI59hHdxA6z2FTpgVw/viewform"),
    );
  }
}
