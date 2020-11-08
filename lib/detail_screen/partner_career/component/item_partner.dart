import 'package:flutter/material.dart';

import '../../../constants.dart';

class ItemPartner extends StatelessWidget {
  int index;
  ItemPartner(int index) {
    index = index;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Constants.greyColor,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Constants.whiteColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Text(
              "Kamar Pasien",
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Constants.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
