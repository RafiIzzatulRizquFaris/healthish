import 'dart:ui';

import 'package:flutter/material.dart';

import '../../helper/constants.dart';

class DetailControl extends StatefulWidget {
  DetailControl({Key key}) : super(key: key);

  @override
  _DetailControlState createState() => _DetailControlState();
}

class _DetailControlState extends State<DetailControl> {
  String desc =
      "Amet - minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit";

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
                "Detail",
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kontrol Mingguan",
                style: TextStyle(color: Constants.blueColor, fontSize: 16),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Waktunya Kontrol",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "06 Aug 2020",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kamis,"),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "08.30",
                        style:
                            TextStyle(color: Constants.blueColor, fontSize: 24),
                      )
                    ],
                  ),
                  Container(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        width: 40,
                      )),
                  Icon(Icons.location_on_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "RS SMK DEV",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Jl.akses tb no.9",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(desc)
            ],
          ),
        ),
      ),
    );
  }
}
