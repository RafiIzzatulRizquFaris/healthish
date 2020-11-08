import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/detail_screen/detail_booking.dart';

class BookingSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingSheetState();
  }
}

class BookingSheetState extends State<BookingSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final String alertRegist =
      "Maaf, anda belum terdaftar dalam aplikasi. Harap daftar terlebih dahulu untuk dapat membooking jadwal dengan dokter yang bersangkutan";
  int selectedRadioTile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Constants.whiteColor,
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alertRegist,
                  style:
                      TextStyle(color: Constants.greyColorRegisterBottomSheet),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Nama",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: 1,
                      onChanged: (val) {},
                    ),
                    Text(
                      'Pria',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 0,
                      groupValue: 1,
                      onChanged: (val) {},
                    ),
                    Text(
                      'Wanita',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "No Handphone",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'No Handphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 5,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textColor: Constants.greyColorCancel,
                          color: Constants.greyColorTab,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Batal'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 5,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textColor: Constants.whiteColor,
                          color: Constants.blueColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBooking()));
                          },
                          child: Text('Daftar'),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
