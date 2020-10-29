import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layanan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LayananState();
  }
}

class LayananState extends State<Layanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Layanan",
        ),
      ),
    );
  }
}
