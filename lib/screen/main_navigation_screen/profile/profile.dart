import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/contract/booking_contract.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/contract/user_contract.dart';
import 'package:healthish/screen/detail_control/detail_control.dart';
import 'package:healthish/presenter/booking_presenter.dart';
import 'package:healthish/presenter/event_presenter.dart';
import 'package:healthish/presenter/user_presenter.dart';
import 'package:healthish/screen/component_global/custom_tab_indicator.dart';
import 'package:healthish/screen/detail_account/detail_account.dart';
import 'package:healthish/screen/detail_content/detail_content.dart';
import 'package:healthish/screen/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'component/booking_history_tab.dart';
import 'component/notification_tab.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin
    implements UserContractView, BookingContractView, EventContractView {
  bool isLogin;
  TabController tabController;
  UserPresenter userPresenter;
  EventPresenter eventPresenter;
  BookingPresenter bookingPresenter;
  List<DocumentSnapshot> dataBookingHistory;
  List<DocumentSnapshot> dataNotif = List<DocumentSnapshot>();
  bool loadingUser;
  bool loadingEvent;
  bool loadingBooking;
  String name = "name";
  String gender = "gender";
  String telephone = "telephone";
  String image = "image";
  String id = "id";
  String historyBadge = "0";
  String eventBadge = "0";
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
    eventPresenter = EventPresenter(this);
    bookingPresenter = BookingPresenter(this);
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
                                            return DetailAccount(
                                              image: image,
                                              name: name,
                                              gender: gender,
                                              id: id,
                                            );
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
                                                eventBadge,
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
                                                historyBadge,
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
                                        dataNotif == null ||
                                                dataNotif.length == 0
                                            ? Center(
                                                child: Text("Tidak ada data"),
                                              )
                                            : loadingEvent
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Constants.blueColor,
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    shrinkWrap: true,
                                                    itemCount: dataNotif.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => dataNotif[index]
                                                                            [
                                                                            "type"] ==
                                                                        "Informasi Booking"
                                                                    ? DetailControl(
                                                                        dataBook:
                                                                            dataNotif[index],
                                                                      )
                                                                    : DetailContent(
                                                                        type:
                                                                            "Event",
                                                                        dataContent:
                                                                            dataNotif[index],
                                                                      )));
                                                      },
                                                      child: NotificationTab(
                                                          dataNotif:
                                                              dataNotif[index]),
                                                    ),
                                                  ),
                                        dataBookingHistory == null ||
                                                dataBookingHistory.length == 0
                                            ? Center(
                                                child: Text("Tidak ada data"),
                                              )
                                            : loadingBooking
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Constants.blueColor,
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        dataBookingHistory
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailControl(
                                                              dataBook:
                                                                  dataBookingHistory[
                                                                      index],
                                                            ),
                                                          ),
                                                        ).then((value) {
                                                          bookingPresenter
                                                              .loadBookingData(
                                                                  id);
                                                        });
                                                      },
                                                      child: BookingHistoryTab(
                                                        dataBook:
                                                            dataBookingHistory[
                                                                index],
                                                      ),
                                                    ),
                                                  ),
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
      String prefId = preferences.getString(Constants.KEY_ID).toString();
      userPresenter.loadUserData(prefId);
      eventPresenter.loadEventData();
      bookingPresenter.loadBookingData(prefId);
      setState(() {
        id = prefId;
        isLogin = loginPref;
        loadingUser = true;
        loadingBooking = true;
        loadingEvent = true;
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

  @override
  onError(error) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  onSuccessBooking(List<DocumentSnapshot> value) {
    setState(() {
      if (value.isNotEmpty || value != null || value.length > 0) {
        List<String> listHistoryLength = List<String>();
        for (int i = 0; i < value.length; i++) {
          if (value[i].data['read'] == 'unread') {
            listHistoryLength.add(value[i].data['read']);
          }
        }
        historyBadge = listHistoryLength.length.toString();
        dataBookingHistory = value.toList();
        eventBadge = dataNotif.length.toString();
        dataNotif.addAll(value.take(1).toList());
        loadingBooking = false;
      } else {
        historyBadge = "0";
      }
    });
  }

  @override
  onErrorEventData(error) {
    // TODO: implement onErrorEventData
    throw UnimplementedError();
  }

  @override
  onSuccessEventData(List<DocumentSnapshot> value) {
    setState(() {
      if (value.isNotEmpty || value != null || value.length > 0) {
        dataNotif.addAll(value.reversed.take(5).toList());
        eventBadge = dataNotif.length.toString();
        loadingEvent = false;
      } else {
        eventBadge = "0";
      }
    });
  }
}
