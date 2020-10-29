import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/navigation_screen/booking.dart';
import 'package:healthish/navigation_screen/home.dart';
import 'package:healthish/navigation_screen/layanan.dart';
import 'package:healthish/navigation_screen/profile.dart';

class MainNavigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainNavigationState();
  }

}

class MainNavigationState extends State<MainNavigation>{

  int selectedIndex = 0;
  List<Widget> screenWidget = [
    Home(),
    Layanan(),
    Booking(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenWidget[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.whiteColor,
        index: selectedIndex,
        color: Constants.whiteColor,
        buttonBackgroundColor: Constants.blueColor,
        animationCurve: Curves.easeInCirc,
        animationDuration: Duration(milliseconds: 250),
        items: [
          Container(
            child: Icon(Icons.home_outlined, size: 30, color: selectedIndex == 0 ? Constants.whiteColor : Constants.greyColor,),
            padding: EdgeInsets.all(5),
          ),
          Container(
            child: Icon(Icons.medical_services_outlined, size: 30, color: selectedIndex == 1 ? Constants.whiteColor : Constants.greyColor,),
            padding: EdgeInsets.all(5),
          ),
          Container(
            child: Icon(Icons.date_range_outlined, size: 30, color: selectedIndex == 2 ? Constants.whiteColor : Constants.greyColor,),
            padding: EdgeInsets.all(5),
          ),
          Container(
            child: Icon(Icons.person_outline_rounded, size: 30, color: selectedIndex == 3 ? Constants.whiteColor : Constants.greyColor,),
            padding: EdgeInsets.all(5),
          ),
          Container(
            child: Icon(Icons.more_vert_rounded, size: 30, color: selectedIndex == 4 ? Constants.whiteColor : Constants.greyColor,),
            padding: EdgeInsets.all(5),
          ),
        ],
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

}