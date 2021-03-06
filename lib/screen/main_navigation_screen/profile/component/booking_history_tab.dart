import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';


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
          child: SizedBox.expand(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: FittedBox(
                fit: BoxFit.fill,
                child: StreamBuilder(
                  stream: Firestore.instance.collection('${Constants.doctorCollections}').document('${dataBook['doctor_id']}').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Image.network(snapshot.data['image']);
                  },
                ),
              ),
            ),
          ),
        ),
        title: StreamBuilder(
          stream: Firestore.instance.collection('${Constants.doctorCollections}').document('${dataBook['doctor_id']}').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            }
            return Text(
              snapshot.data["name"],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Constants.blackColor,
              ),
            );
          },
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            StreamBuilder(
              stream: Firestore.instance.collection('${Constants.doctorCollections}').document('${dataBook['doctor_id']}').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                }
                return Text(
                  snapshot.data["specialist"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Constants.blackColor),
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${subtractDate(
                    dataBook['create_at'],
                  )}",
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
                    "${checkIsDone(dataBook['date'], dataBook['time'])}",
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

  String checkIsDone(String bookDate, String bookTime) {
    var parsedDate = DateTime.parse("$bookDate $bookTime:00");
    var todayDate = DateTime.now();

    var differenceDays = todayDate.difference(parsedDate);
    if (differenceDays.inDays < 0) {
      return "${parsedDate.difference(todayDate).inDays.toString()} Hari lagi";
    } else if (differenceDays.inHours < 0) {
      return "${parsedDate.difference(todayDate).inHours.toString()} Jam lagi";
    }
    return "Selesai";
  }
}
