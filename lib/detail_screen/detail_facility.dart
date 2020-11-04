import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';

class DetailFacility extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String desc;

  DetailFacility({
    this.imgUrl,
    this.title,
    this.desc,
  });

  @override
  State<StatefulWidget> createState() {
    return DetailFacilityState();
  }
}

class DetailFacilityState extends State<DetailFacility> {
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
                "Fasilitas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
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
                "Foto ${widget.title}",
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
                "Fasilitas",
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
                top: 12,
                left: 20,
              ),
              child: Text(
                "${widget.title} - ${widget.desc}",
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
