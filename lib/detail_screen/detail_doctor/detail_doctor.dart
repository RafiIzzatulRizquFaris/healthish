import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/detail_screen/detail_booking.dart';
import 'package:healthish/detail_screen/detail_doctor/component/bookingSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class DetailDoctor extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String specialist;
  final String description;
  final String credential;
  final String academy;
  final List scheduleDay;
  final List scheduleTime;
  final List schedulePlace;

  DetailDoctor({
    this.name,
    this.specialist,
    this.description,
    this.credential,
    this.academy,
    this.scheduleDay,
    this.scheduleTime,
    this.schedulePlace,
    this.image,
    this.id,
  });

  @override
  State<StatefulWidget> createState() {
    return DetailDoctorState();
  }
}

class DetailDoctorState extends State<DetailDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          alignment: Alignment.centerLeft,
          color: Colors.transparent,
          padding: EdgeInsets.all(18),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  decoration: BoxDecoration(
                    color: Constants.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 40.0,
                  width: 40,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Constants.blackColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Constants.whiteColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: 18,
            left: 14,
            bottom: 14,
            right: 14,
          ),
          child: FlatButton(
            padding: EdgeInsets.all(12),
            textColor: Constants.whiteColor,
            color: Constants.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              if (preferences.getBool(Constants.KEY_LOGIN) == null) {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return BookingSheet();
                  },
                );
              } else {
                String idUser =
                    preferences.getString(Constants.KEY_ID).toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBooking(
                      name: widget.name,
                      image: widget.image,
                      specialist: widget.specialist,
                      idDoctor: widget.id,
                      idUser: idUser,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Buat Janji',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: SizedBox.expand(
                child: FittedBox(
                  child: Image.network(widget.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.6,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      width: MediaQuery.of(context).size.width + 75,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Constants.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 24, right: 18, left: 18),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.medical_services_outlined,
                                  color: Constants.greyColor,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.specialist,
                                  style: TextStyle(
                                    color: Constants.greyColor,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Jadwal",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Constants.blueColor,
                                fontSize: 26,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              children: scheduleInfoList(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Biografi",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Constants.blueColor,
                                fontSize: 26,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Kredensial",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Constants.blueColor,
                                fontSize: 26,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              widget.credential,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Afliansi Akademik",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Constants.blueColor,
                                fontSize: 26,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              widget.academy,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 85,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> scheduleInfoList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < widget.scheduleDay.length; i++) {
      list.add(
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.scheduleDay[i]),
              Text(widget.scheduleTime[i]),
            ],
          ),
          trailing: Text(widget.schedulePlace[i]),
        ),
      );
    }
    return list;
  }
}
