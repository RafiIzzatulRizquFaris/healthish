import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TitleSection extends StatelessWidget{

  final String image;
  final String title;

  TitleSection(this.image, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
          ),
          child: Image.asset(image),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

}