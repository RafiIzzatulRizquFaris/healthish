import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';

class NotificationTab extends StatelessWidget {
  final DocumentSnapshot dataNotif;

  const NotificationTab({Key key, this.dataNotif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Constants.whiteColor,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Constants.blueWhiteColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: typeIcon(dataNotif["type"]),
        ),
        title: Text(
          dataNotif["title"],
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
              dataNotif["description"],
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
                  subtractDate(dataNotif["create_at"]),
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                ),
                Container(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String subtractDate(String bookDate) {
    var parsedDate = DateTime.parse("$bookDate:00");
    var todayDate = DateTime.now();

    var differenceDays = parsedDate.difference(todayDate);
    if (differenceDays.inDays < 0) {
      return "${todayDate.difference(parsedDate).inDays.toString()} Hari yang lalu";
    } else if (differenceDays.inHours < 0) {
      return "${todayDate.difference(parsedDate).inHours.toString()} Jam yang lalu";
    }
    return "${todayDate.difference(parsedDate).inMinutes.toString()} Menit yang lalu";
  }

  Widget typeIcon(String type) {
    switch (type) {
      case "Event":
        return Image.asset("assets/event.png");
        break;
      case "Promo":
        return Image.asset("assets/coupon.png");
        break;
      case "Kontrol":
        return Image.asset("assets/stethoscope.png");
        break;
      default:
    }
  }
}
