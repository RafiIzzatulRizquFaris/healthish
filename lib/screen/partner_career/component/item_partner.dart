import 'package:flutter/material.dart';

import '../../../helper/constants.dart';

class ItemPartner extends StatelessWidget {
  final String image;

  const ItemPartner({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      height: 100,
      width: 150,
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
            alignment: Alignment.center,
            child: Image.network(
              image,
              width: 130.0,
            ),
          ),
        ],
      ),
    );
  }
}
