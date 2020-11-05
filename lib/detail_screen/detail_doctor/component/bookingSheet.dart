import 'package:flutter/material.dart';
import 'package:healthish/detail_screen/detail_booking.dart';

class BookingSheet extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedRadioTile;
  String alertRegist =
      "Maaf, anda belum terdaftar dalam aplikasi. Harap daftar terlebih dahulu untuk dapat membooking jadwal dengan dokter yang bersangkutan";

  setSelectedRadioTile(int val) {
    selectedRadioTile = val;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 60 / 100,
      child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alertRegist),
                SizedBox(
                  height: 24,
                ),
                Text("Nama"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text("Jenis Kelamin"),
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
                Text("No Handphone"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'No Handphone',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text("Email"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Batal'),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailBooking()));
                      },
                      child: Text('Daftar'),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
