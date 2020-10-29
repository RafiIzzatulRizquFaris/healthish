import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Text(
          "Booking",
        ),
      ),
    );
  }
}
