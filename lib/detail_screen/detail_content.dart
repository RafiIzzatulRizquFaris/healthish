import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DetailContent extends StatefulWidget {
  final String type;
  final DocumentSnapshot dataContent;

  DetailContent({Key key, this.type, this.dataContent}) : super(key: key);

  @override
  DetailContentState createState() => DetailContentState();
}

class DetailContentState extends State<DetailContent> {
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
                widget.type,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                color: Constants.greyColor,
              ),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(widget.dataContent["image"]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 8,
              ),
              alignment: Alignment.center,
              child: Text(
                "Foto ${widget.type}",
                style: TextStyle(
                  color: Constants.greyColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                left: 20,
              ),
              child: Text(
                widget.type,
                style: TextStyle(
                  color: Constants.blueColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 20,
              ),
              child: Text(
                widget.dataContent['title'],
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            checkDate(),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                left: 20,
              ),
              child: Text(
                "${widget.type} - ${widget.dataContent["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Constants.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkDate() {
    if (widget.type == "Partner" || widget.type == "Fasilitas") {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: 20,
      ),
      child: Text(
        widget.dataContent['date'],
        style: TextStyle(
          fontSize: 14,
          color: Constants.greyColor,
        ),
      ),
    );
  }
}
