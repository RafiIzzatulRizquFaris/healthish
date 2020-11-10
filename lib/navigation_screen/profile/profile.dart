import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/user_contract.dart';
import 'package:healthish/custom_tab_indicator.dart';
import 'package:healthish/detail_screen/detail_account.dart';
import 'package:healthish/login.dart';
import 'package:healthish/navigation_screen/profile/component/bookingHistoryTab.dart';
import 'package:healthish/navigation_screen/profile/component/notificationTab.dart';
import 'package:healthish/presenter/user_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin
    implements UserContractView {
  var isLogin;
  TabController tabController;
  UserPresenter userPresenter;
  bool loadingUser;
  String name = "name";
  String gender = "gender";
  String telephone = "telephone";
  String image = "image";
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

  ProfileState() {
    userPresenter = UserPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    getPreferenceAccountData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: isLogin == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Anda Belum Login"),
                  SizedBox(
                    height: 8,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Constants.blueColor,
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: Constants.whiteColor,
                      ),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        )),
                  )
                ],
              ),
            )
          : loadingUser
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Constants.blueColor,
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      color: Constants.blueColor,
                      child: SafeArea(
                        child: Column(
                          children: [
                            appBar,
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
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
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.more_horiz_rounded),
                                        color: Constants.blackColor,
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailAccount();
                                          }));
                                        },
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          color: Constants.blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    child: Text(
                                      gender,
                                      style: TextStyle(
                                        color: Constants.blackColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    telephone,
                                    style: TextStyle(
                                      color: Constants.greyColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                      bottom: 10,
                                      top: 20,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Constants.greyColorTab,
                                      ),
                                      child: TabBar(
                                        controller: tabController,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: CustomTabIndicator(),
                                        labelColor: Constants.blackColor,
                                        tabs: [
                                          Tab(
                                            child: Badge(
                                              badgeContent: Text(
                                                '2',
                                                style: TextStyle(
                                                  color: Constants.whiteColor,
                                                ),
                                              ),
                                              badgeColor: Constants.redColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Notifikasi"),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Badge(
                                              badgeContent: Text(
                                                '1',
                                                style: TextStyle(
                                                  color: Constants.whiteColor,
                                                ),
                                              ),
                                              badgeColor: Constants.redColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Histori Booking"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: tabController,
                                      children: [
                                        NotificationTab(),
                                        BookingHistoryTab(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: appBar.preferredSize.height + 50,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Constants.greyColor,
                              ),
                              child: SizedBox.expand(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: FadeInImage.memoryNetwork(
                                      image: image,
                                      placeholder: kTransparentImage,
                                    ),
                                  ),
                                ),
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

  void getPreferenceAccountData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loginPref = preferences.getBool(Constants.KEY_LOGIN);
    if (loginPref == null) {
      setState(() {
        isLogin = null;
      });
    } else {
      userPresenter
          .loadUserData(preferences.getString(Constants.KEY_ID).toString());
      setState(() {
        isLogin = loginPref;
        loadingUser = true;
      });
    }
  }

  @override
  onErrorUserData(error) {
    setState(() {
      isLogin = null;
    });
  }

  @override
  onSuccessUserData(DocumentSnapshot value) {
    setState(() {
      image = value.data['image'].toString();
      name = value.data['name'].toString();
      gender = value.data['gender'].toString();
      telephone = value.data['phonenumber'].toString();
      loadingUser = false;
    });
  }
}
