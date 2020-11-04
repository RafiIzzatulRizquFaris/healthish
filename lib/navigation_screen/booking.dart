import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/detail_screen/detail_doctor/detail_doctor.dart';

class Booking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingState();
  }
}

class BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Text(
            "Booking",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w800,
              fontSize: 32,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => DetailDoctor())),
            child: itemBuilderDoctor(context, index),
          );
        },
      ),
    );
  }

  Widget itemBuilderDoctor(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Constants.greyColor,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
          ),
        ),
        title: Text(
          "Dokter $index",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Constants.blackColor),
        ),
        subtitle: Text(
          "Deskripsi singkat dokter $index",
          style: TextStyle(color: Constants.greyColor),
        ),
      ),
    );
  }
}
