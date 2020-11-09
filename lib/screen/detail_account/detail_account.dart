import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';

class DetailAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailAccountState();
  }
}

class DetailAccountState extends State<DetailAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
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
                "Pengaturan",
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
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Constants.greyColor,
                borderRadius: BorderRadius.circular(1000),
              ),
              // child: SizedBox.expand(
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.all(Radius.circular(1000)),
              //     child: FittedBox(
              //       fit: BoxFit.fill,
              //       child: Image.network(listDoctor[index]['image']),
              //     ),
              //   ),
              // ),
            ),
            title: Text(
              "Name",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            subtitle: Text(
              "Gender",
              style: TextStyle(color: Constants.greyColor),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Text("Akun"),
          ),
          ListTile(
            leading: Icon(
              Icons.lock_outline_rounded,
              color: Constants.blackColor,
            ),
            title: Text(
              "Ganti Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Constants.blackColor,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_outlined,
              color: Constants.blackColor,
            ),
            title: Text(
              "Keluar Akun",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Constants.blackColor,
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.bottomCenter,
            child: Text("Healthish V1.0"),
          ),
        ],
      ),
    );
  }
}
