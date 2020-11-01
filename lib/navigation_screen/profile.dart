import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthish/constants.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  PreferredSize appBar = PreferredSize(
    preferredSize: Size.fromHeight(100),
    child: Container(
      color: Constants.blueColor,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(top: 35, left: 20),
      child: Text(
        "Profile",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Constants.whiteColor,
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: Stack(
        children: [
          Container(
            color: Constants.blueColor,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  appBar,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child:
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(
                        top: appBar.preferredSize.height + 100,
                      ),
                      decoration: BoxDecoration(
                        color: Constants.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: appBar.preferredSize.height + 50,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Constants.greyColor
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
