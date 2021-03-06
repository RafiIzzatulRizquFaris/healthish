import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthish/contract/booking_contract.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/presenter/booking_presenter.dart';
import 'package:healthish/presenter/event_presenter.dart';
import 'package:healthish/screen/about/about.dart';
import 'package:healthish/screen/feedback_form/feedback_form.dart';
import 'package:healthish/screen/main_navigation_screen/booking/booking.dart';
import 'package:healthish/screen/main_navigation_screen/home/home.dart';
import 'package:healthish/screen/main_navigation_screen/service/service_screen.dart';
import 'package:healthish/screen/partner_career/partner_career.dart';
import 'package:healthish/screen/main_navigation_screen/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainNavigationState();
  }
}

Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {
  print('onBackgroundMessage: $message');
  if (message.containsKey('data')) {
    String name = '';
    String age = '';
    var data = message['data'];
    name = data['name'];
    age = data['age'];
    print('onBackgroundMessage: name: $name & age: $age');
  }
  return null;
}

class MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin
    implements BookingContractView, EventContractView {
  final firebaseMessaging = FirebaseMessaging();
  int selectedIndex = 0;
  int selectedIcon = 0;
  EventPresenter eventPresenter;
  BookingPresenter bookingPresenter;
  List<DocumentSnapshot> dataBookingHistory;
  List<DocumentSnapshot> dataNotif = List<DocumentSnapshot>();
  List<Widget> screenWidget = [
    Home(),
    ServiceScreen(),
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
  bool loadingEvent;
  bool loadingBooking;
  int notificationBadge = 0;
  bool isLogin;
  String id = "id";

  MainNavigationState() {
    eventPresenter = EventPresenter(this);
    bookingPresenter = BookingPresenter(this);
  }

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
    firebaseMessaging.configure(
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: (message) {
        print(message);
      },
      onMessage: (message) {
        print(message);
      },
      onResume: (message) {
        print(message);
      },
    );
    firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      print('Settings registered: $settings');
    });
    firebaseMessaging.getToken().then((token) {
      print(" Token Firebase : $token");
    });
    firebaseMessaging.subscribeToTopic('general');
    setPersonalTopic();
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
    getPreferenceAccountData();
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
                        builder: (context) => About(),
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
              child: Badge(
                badgeContent: Text(
                  notificationBadge.toString() ?? "0",
                  style: TextStyle(
                    color: Constants.whiteColor,
                  ),
                ),
                badgeColor: Constants.redColor,
                child: Padding(
                  padding: selectedIcon == 3 ? EdgeInsets.all(0) : EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 30,
                    color: selectedIcon == 3
                        ? Constants.whiteColor
                        : Constants.greyColor,
                  ),
                ),
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

  void setPersonalTopic() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idDocumentUser = preferences.getString(Constants.KEY_ID);
    if (idDocumentUser.isNotEmpty ||
        idDocumentUser != null ||
        idDocumentUser.length > 0) {
      firebaseMessaging.subscribeToTopic(idDocumentUser);
    }
  }

  void getPreferenceAccountData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loginPref = preferences.getBool(Constants.KEY_LOGIN);
    if (loginPref == null) {
      setState(() {
        isLogin = null;
      });
    } else {
      String prefId = preferences.getString(Constants.KEY_ID).toString();
      eventPresenter.loadEventData();
      bookingPresenter.loadBookingData(prefId);
      setState(() {
        id = prefId;
        isLogin = loginPref;
        loadingBooking = true;
        loadingEvent = true;
      });
    }
  }

  @override
  onError(error) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  onErrorEventData(error) {
    // TODO: implement onErrorEventData
    throw UnimplementedError();
  }

  @override
  onSuccessBooking(List<DocumentSnapshot> value) {
    setState(() {
      notificationBadge += value.take(1).toList().length;
    });
  }

  @override
  onSuccessEventData(List<DocumentSnapshot> value) {
    // TODO: implement onSuccessEventData
    setState(() {
      notificationBadge += value.take(5).toList().length;
    });
  }
}
