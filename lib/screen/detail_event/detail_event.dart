import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';

class DetailEvent extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String date;
  final String desc;
  final String type;

  DetailEvent({
    this.imgUrl,
    this.title,
    this.date,
    this.desc,
    this.type,
  });

  @override
  State<StatefulWidget> createState() {
    return DetailEventState();
  }
}

class DetailEventState extends State<DetailEvent> {
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
                "Event & Promo",
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
                  child: Image.network(widget.imgUrl),
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
                widget.title,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 20,
              ),
              child: Text(
                widget.date,
                style: TextStyle(
                  fontSize: 14,
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
                "${widget.type} - ${widget.desc}",
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
}
