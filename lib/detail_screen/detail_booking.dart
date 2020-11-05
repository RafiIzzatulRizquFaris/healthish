import 'package:flutter/material.dart';

import '../constants.dart';

class DetailBooking extends StatefulWidget {
  DetailBooking({Key key}) : super(key: key);

  @override
  _DetailBookingState createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.arrow_back,
                  color: Constants.blackColor,
                ),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Booking Confirm",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          "https://www.rssatyanegara.com/wp-content/files_mf/1411616552Dr.ImansyahSpPD.jpg",
                          height: 100.0,
                        ),
                      )),
                  SizedBox(
                    width: 24,
                  ),
                  Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dokter 1",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Umum",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Divider(
              thickness: 6,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Booking Detail",
                style: TextStyle(
                    color: Constants.blueColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            Container(
              color: const Color(0xfff4f4f4),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking Untuk",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        FlatButton(
                          textColor: Constants.blueColor,
                          onPressed: () {
                            // Respond to button press
                          },
                          child: Text("Ganti Pasien"),
                        )
                      ],
                    ),
                    Text(
                      "Nama : Irfan Trianto",
                      style: TextStyle(color: Color(0xff8B8B8B)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("Jenis Kelamin : Laki - laki",
                        style: TextStyle(color: Color(0xff8B8B8B))),
                    SizedBox(
                      height: 4,
                    ),
                    Text("Status : Saya Sendiri",
                        style: TextStyle(color: Color(0xff8B8B8B)))
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Booking Tanggal",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Text(
                            "Jumat, 23 Oct 2020",
                            style: TextStyle(color: Color(0xffEE7421)),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Constants.blueColor,
                              ),
                              onPressed: () {})
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Pesan", style: TextStyle(fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: 75,
        color: Constants.whiteColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: 18,
            left: 14,
            bottom: 14,
            right: 14,
          ),
          child: RaisedButton(
            textColor: Constants.whiteColor,
            color: Constants.blueColor,
            onPressed: () {},
            child: Text('Konfirmasi'),
          ),
        ),
      ),
    );
  }
}
