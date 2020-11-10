import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ItemCareer extends StatelessWidget {
  final DocumentSnapshot careerData;
  const ItemCareer({Key key, this.careerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      height: MediaQuery.of(context).size.height / 3.3,
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Constants.greyColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                    careerData['image']
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              top: 8,
              right: 8,
            ),
            child: Text(
              'Career',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Constants.blueColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              careerData['title'],
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              careerData['date'],
            ),
          ),
        ],
      ),
    );
  }
}
