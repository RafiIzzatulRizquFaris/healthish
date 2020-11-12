import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/detail_screen/about/detail_about.dart';
import 'package:healthish/detail_screen/feedback_form.dart';
import 'package:healthish/navigation_screen/booking.dart';
import 'package:healthish/navigation_screen/home.dart';
import 'package:healthish/navigation_screen/layanan.dart';
import 'package:healthish/detail_screen/partner_career/partner_career.dart';
import 'package:healthish/navigation_screen/profile/profile.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainNavigationState();
  }
}

class MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  int selectedIcon = 0;
  List<Widget> screenWidget = [
    Home(),
    Layanan(),
    Booking(),
    Profile(),
    PartnerCareer(),
  ];
  AnimationController animationController;
  AnimationController secondAnimationController;
  AnimationController thirdAnimationController;
  Animation animation;
  Animation secondAnimation;
  Animation thirdAnimation;
  CurvedNavigationBar curvedNavigationBar = CurvedNavigationBar(items: [
    Container(
      child: Icon(Icons.home_outlined),
    ),
  ]);
  double right = -200;
  double bottom = 0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    secondAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    thirdAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(animationController);
    secondAnimation =
        Tween(begin: -1.0, end: 0.0).animate(secondAnimationController);
    thirdAnimation =
        Tween(begin: -1.0, end: 0.0).animate(thirdAnimationController);
    super.initState();
    animationController.addListener(() {
      setState(() {});
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
            child: Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: FlatButton(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      "Feedback",
                      style: TextStyle(
                        color: Constants.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.favorite_border_rounded,
                      color: Constants.whiteColor,
                    ),
                  ],
                ),
                splashColor: Constants.redColor,
                color: Constants.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackForm(),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: secondAnimation.value * 220,
            bottom: curvedNavigationBar.height + 60,
            child: Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: FlatButton(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      "Partner & Career",
                      style: TextStyle(
                        color: Constants.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.amp_stories_outlined,
                      color: Constants.whiteColor,
                    ),
                  ],
                ),
                splashColor: Constants.redColor,
                color: Constants.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  animationController.reverse();
                  secondAnimationController.reverse();
                  thirdAnimationController.reverse();
                },
              ),
            ),
          ),
          Positioned(
            right: thirdAnimation.value * 240,
            bottom: curvedNavigationBar.height + 120,
            child: Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: FlatButton(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      "Tentang Kami",
                      style: TextStyle(
                        color: Constants.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.info_outline_rounded,
                      color: Constants.whiteColor,
                    ),
                  ],
                ),
                splashColor: Constants.redColor,
                color: Constants.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailAbout(),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(children: [
        CurvedNavigationBar(
          backgroundColor: Constants.whiteColor,
          index: selectedIndex,
          color: Constants.whiteColor,
          buttonBackgroundColor: Constants.blueColor,
          animationCurve: Curves.easeInCirc,
          animationDuration: Duration(milliseconds: 250),
          items: [
            Container(
              child: Icon(
                Icons.home_outlined,
                size: 30,
                color: selectedIcon == 0
                    ? Constants.whiteColor
                    : Constants.greyColor,
              ),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(
                Icons.medical_services_outlined,
                size: 30,
                color: selectedIcon == 1
                    ? Constants.whiteColor
                    : Constants.greyColor,
              ),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(
                Icons.date_range_outlined,
                size: 30,
                color: selectedIcon == 2
                    ? Constants.whiteColor
                    : Constants.greyColor,
              ),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(
                Icons.person_outline_rounded,
                size: 30,
                color: selectedIcon == 3
                    ? Constants.whiteColor
                    : Constants.greyColor,
              ),
              padding: EdgeInsets.all(5),
            ),
            Container(
              child: Icon(
                Icons.more_vert_rounded,
                size: 30,
                color: selectedIcon == 4
                    ? Constants.whiteColor
                    : Constants.greyColor,
              ),
              padding: EdgeInsets.all(5),
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIcon = index;
            });
            if (index == 4) {
              print("Pop up Menu");
              if (animationController.isCompleted) {
                animationController.reverse();
                secondAnimationController.reverse();
                thirdAnimationController.reverse();
              } else {
                animationController.forward();
                secondAnimationController.forward();
                thirdAnimationController.forward();
              }
            } else {
              setState(() {
                selectedIndex = index;
              });
              if (animationController.isCompleted) {
                animationController.reverse();
                secondAnimationController.reverse();
                thirdAnimationController.reverse();
              }
            }
          },
        ),
      ]),
    );
  }
}
