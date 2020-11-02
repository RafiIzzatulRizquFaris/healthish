import 'package:flutter/material.dart';

import '../../../constants.dart';

class BookingHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: itemBuilderHistoryBooking,
    );
  }

  Widget itemBuilderHistoryBooking(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(5),
      color: index == 0 || index == 1
          ? Constants.greyColorTab
          : Constants.whiteColor,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Deskripsi singkat dokter $index Deskripsi singkat dokter $index Deskripsi singkat dokter $index Deskripsi singkat dokter $index",
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
                  "2 jam yang lalu",
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                ),
                index == 0 || index == 1
                    ? Container(
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
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
