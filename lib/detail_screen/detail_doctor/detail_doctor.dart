import 'package:flutter/material.dart';
import 'package:healthish/detail_screen/detail_doctor/component/bookingSheet.dart';

import '../../constants.dart';

class DetailDoctor extends StatefulWidget {
  DetailDoctor({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailDoctorState();
  }
}

class DetailDoctorState extends State<DetailDoctor> {
  String lorem =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 15.0,
                alignment: Alignment.center,
                color: Constants.whiteColor,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Constants.blackColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.orange,
                ),
              ),
            ),
          )),
      bottomNavigationBar: Container(
          height: 75,
          color: Constants.whiteColor,
          child: Padding(
            padding: EdgeInsets.only(top: 18, left: 14, bottom: 14, right: 14),
            child: RaisedButton(
              textColor: Constants.whiteColor,
              color: Constants.blueColor,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BookingSheet();
                    });
              },
              child: Text('Buat Janji'),
            ),
          )),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Image.network(
                "https://yt3.ggpht.com/a/AGF-l78nCfL7DcCWlgqad4XWgoHhJ5IzSfBT9SSZJA=s900-c-k-c0xffffffff-no-rj-mo"),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.5,
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
                              "Dokter Ato",
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
                                  "Umum",
                                  style: TextStyle(
                                      color: Constants.greyColor, fontSize: 16),
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
                                  fontSize: 26),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Senin"),
                                  Text("08.00-14.00 WIB")
                                ],
                              ),
                              trailing: Text("RS SMKDEV"),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Senin"),
                                  Text("08.00-14.00 WIB")
                                ],
                              ),
                              trailing: Text("RS SMKDEV"),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Senin"),
                                  Text("08.00-14.00 WIB")
                                ],
                              ),
                              trailing: Text("RS SMKDEV"),
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
                              lorem,
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
                              lorem,
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
                              lorem,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 80,
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
}
