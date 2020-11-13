import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class BookingHistoryTab extends StatelessWidget {
  final DocumentSnapshot dataBook;

  const BookingHistoryTab({this.dataBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: dataBook['read'] == "unread"
          ? Constants.greyColorTab
          : Constants.whiteColor,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Constants.greyColor,
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        title: Text(
          dataBook['doctor_id'],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Constants.blackColor),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Umum",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Constants.blackColor),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  calculateDate(dataBook['date']),
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                ),
                dataBook['read'] == "unread" ? Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Constants.redColor,
                  ),
                  child: Text(
                    "New",
                    style: TextStyle(
                      color: Constants.whiteColor,
                    ),
                  ),
                ) : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  String calculateDate(String bookDate) {
    List<String> splitBookDate = bookDate.split('-');
    String year = splitBookDate[2];
    String month = splitBookDate[1];
    String day = splitBookDate[0];
    var parsedDate = DateTime.parse("$year$month$day 00:00:00");
    var todayDate = DateTime.now();

    int differenceDays = parsedDate.difference(todayDate).inDays;
    if (differenceDays == 0){
      return "Hari ini";
    } else if (differenceDays > 0){
      return "${differenceDays.toString()} hari lagi";
    }
    return "${differenceDays.toString()} hari yang lalu";
  }
}
