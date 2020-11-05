import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';

class BookingStatus extends StatefulWidget {
  BookingStatus({Key key}) : super(key: key);

  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Constants.blueColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Constants.whiteColor,
              size: 150,
            ),
            SizedBox(height: 20,),
            Text(
              "Booking Sukses!",
              style: TextStyle(
                  color: Constants.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
            SizedBox(height: 16,),
            Text(
              "Kode booking anda",
              style: TextStyle(color: Constants.whiteColor, fontSize: 16),
            ),
            SizedBox(height: 8,),
            Text(
              "BIJIDS123",
              style: TextStyle(
                  color: Constants.whiteColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8,),
            Container(
              width: 280,
              child: Text(
                "Custumer Service kami akan menghubungi anda untuk konfirmasi selanjutnya",
                style: TextStyle(color: Constants.whiteColor),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        color: Constants.blueColor,
        child: Padding(
            padding: EdgeInsets.only(
              top: 18,
              left: 14,
              bottom: 14,
              right: 14,
            ),
            child: Column(
              children: [
                RaisedButton(
                  textColor: Constants.blueColor,
                  color: Constants.whiteColor,
                  onPressed: () {},
                  child: Text('Lihat Histori'),
                ),
                FlatButton(
                  textColor: Constants.whiteColor,
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text(
                    "Tidak kembali ke home",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
