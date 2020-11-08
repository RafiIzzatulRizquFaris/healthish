import 'package:flutter/material.dart';
import 'package:healthish/detail_screen/change_pasient/component/add_pasientsheet.dart';

import '../../constants.dart';

class ChangePasient extends StatefulWidget {
  ChangePasient({Key key}) : super(key: key);

  @override
  _ChangePasientState createState() => _ChangePasientState();
}

class _ChangePasientState extends State<ChangePasient> {
  int _value = 1;

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
                "Ganti Pasien",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama : Irfan Trianto",
                          style: TextStyle(
                              color: Color(0xff8B8B8B),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Jenis Kelamin : Laki - laki",
                            style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Status : Saya Sendiri",
                            style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _value = 0),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: _value != 0
                            ? BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle)
                            : null,
                        child: _value == 0
                            ? Icon(
                                Icons.check_circle,
                                size: 35,
                                color: Constants.blueColor,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama : Irfan Trianto",
                          style: TextStyle(
                              color: Color(0xff8B8B8B),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Jenis Kelamin : Laki - laki",
                            style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Status : Saya Sendiri",
                            style: TextStyle(
                                color: Color(0xff8B8B8B),
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _value = 1),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: _value != 1
                            ? BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle)
                            : null,
                        child: _value == 1
                            ? Icon(
                                Icons.check_circle,
                                size: 35,
                                color: Constants.blueColor,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
                onPressed: () {
                  showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return AddPasientSheet();
                  });
                },
                child: Text(
                  "Tambah Baru",
                  style: TextStyle(color: Constants.blueColor),
                ))
          ],
        ),
      ),
    );
  }
}
