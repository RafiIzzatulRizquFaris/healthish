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

class MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin{

  int selectedIndex = 0;
  int selectedIcon = 0;
  List<Widget> screenWidget = [
    Home(),
    Layanan(),
    Booking(),
    Profile(),
  ];
  AnimationController animationController;
  Animation animation;
  CurvedNavigationBar curvedNavigationBar = CurvedNavigationBar(items: [
    Container(
      child: Icon(Icons.home_outlined),
    ),
  ]);
  double right = -200;
  double bottom = 0;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250,),);
    animation = Tween(begin: -1.0, end: 0.0).animate(animationController);
    super.initState();
    animationController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screenWidget.elementAt(selectedIndex),
          Positioned(
            right: animation.value * 200,
            bottom: curvedNavigationBar.height,
            child: RaisedButton(
              child: Text("this is button", style: TextStyle(color: Constants.whiteColor,),),
              color: Constants.blackColor,
              onPressed: (){},
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          CurvedNavigationBar(
          backgroundColor: Constants.whiteColor,
          index: selectedIndex,
          color: Constants.whiteColor,
          buttonBackgroundColor: Constants.blueColor,
          animationCurve: Curves.easeInCirc,
          animationDuration: Duration(milliseconds: 250),
          items: [
            Container(
              child: Icon(Icons.home_outlined, size: 30, color: selectedIcon == 0 ? Constants.whiteColor : Constants.greyColor,),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(Icons.medical_services_outlined, size: 30, color: selectedIcon == 1 ? Constants.whiteColor : Constants.greyColor,),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(Icons.date_range_outlined, size: 30, color: selectedIcon == 2 ? Constants.whiteColor : Constants.greyColor,),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(Icons.person_outline_rounded, size: 30, color: selectedIcon == 3 ? Constants.whiteColor : Constants.greyColor,),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(Icons.more_vert_rounded, size: 30, color: selectedIcon == 4 ? Constants.whiteColor : Constants.greyColor,),
              padding: EdgeInsets.all(5),
            ),
          ],
          onTap: (index){
            setState(() {
              selectedIcon = index;
            });
            if (index == 4){
              print("Pop up Menu");
              setState(() {
                // right = 0;
                bottom = curvedNavigationBar.height;
              });
              if (animationController.isCompleted){
                animationController.reverse();
              }else {
                animationController.forward();
              }
            } else {
              setState(() {
                // right = -200;
                selectedIndex = index;
              });
              if (animationController.isCompleted) animationController.reverse();
            }
          },
        ),
        ]
      ),
    );
  }

}