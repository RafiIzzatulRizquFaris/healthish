import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/about_contract.dart';
import 'package:healthish/contract/doctor_contract.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/contract/news_contract.dart';
import 'package:healthish/detail_screen/about/detail_about.dart';
import 'package:healthish/detail_screen/detail_content.dart';
import 'package:healthish/presenter/about_presenter.dart';
import 'package:healthish/presenter/doctor_presenter.dart';
import 'package:healthish/presenter/event_presenter.dart';
import 'package:healthish/presenter/news_presenter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>
    implements
        EventContractView,
        AboutContractView,
        DoctorContractView,
        NewsContractView {
  AboutPresenter aboutPresenter;
  EventPresenter eventPresenter;
  DoctorPresenter doctorPresenter;
  NewsPresenter newsPresenter;
  int carouselIndex = 0;
  List<DocumentSnapshot> listEvent = List<DocumentSnapshot>();
  List<DocumentSnapshot> listAbout = List<DocumentSnapshot>();
  List<DocumentSnapshot> listDoctor = List<DocumentSnapshot>();
  List<DocumentSnapshot> listNews = List<DocumentSnapshot>();
  bool loadingEvent = true;
  bool loadingAbout = true;
  bool loadingDoctor = true;
  bool loadingNews = true;
  bool showMapInfo = false;
  final Set<Marker> markers = {};
  LatLng currentPosition = LatLng(-6.318920, 106.852008);

  final Completer<GoogleMapController> mapController = Completer();
  Future mapFuture = Future.delayed(
    Duration(seconds: 1),
    () => true,
  );

  HomeState() {
    eventPresenter = EventPresenter(this);
    aboutPresenter = AboutPresenter(this);
    doctorPresenter = DoctorPresenter(this);
    newsPresenter = NewsPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    eventPresenter.loadEventData();
    aboutPresenter.loadAboutData();
    doctorPresenter.loadDoctorData();
    newsPresenter.loadNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    carouselEvent(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loadingEvent
                                ? "Loading.."
                                : listEvent[carouselIndex].data["title"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            loadingEvent
                                ? "Loading.."
                                : listEvent[carouselIndex].data["description"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: dotWidget(),
                              ),
                              RaisedButton(
                                color: Constants.blueColor,
                                textColor: Constants.whiteColor,
                                child: Text("Read"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailContent(
                                                type: "Event",
                                                dataContent:
                                                    listEvent[carouselIndex],
                                              )));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Temui Kami",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          FutureBuilder(
                            future: mapFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Constants.whiteColor,
                                  ),
                                );
                              }
                              return GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: currentPosition,
                                  zoom: 14.0,
                                ),
                                markers: markers,
                                onMapCreated: (controller) {
                                  mapController.complete(controller);
                                },
                              );
                            },
                          ),
                          showMapInfo
                              ? Positioned(
                                  right: 8,
                                  left: 8,
                                  bottom: 8,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Constants.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Constants.darkGreyColor,
                                            blurRadius: 50,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        onTap: () async {
                                          await launch(
                                              'https://www.google.com/maps/search/?api=1&query=${listAbout[0]["maps"]['lat']}, ${listAbout[0]["maps"]['long']}');

                                        },
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Constants.greyColor,
                                          ),
                                        ),
                                        title: Text(
                                          listAbout.isNotEmpty
                                              ? listAbout[0]["place_list"][0]["name"].toString()
                                              : "Place Name",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        subtitle: Text(
                                          listAbout.isNotEmpty
                                              ? "${listAbout[0]["place_list"][0]["address"].toString()}\nBuah Batu, Bandung"
                                              : "Place Address",
                                          style: TextStyle(
                                            color: Constants.greyColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  firstAndSecondPlace(
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][0]["name"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][0]["address"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][0]["weekday"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][0]["weekend"].toString()
                        : "",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  firstAndSecondPlace(
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][1]["name"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][1]["address"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][1]["weekday"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][1]["weekend"].toString()
                        : "",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  thirdPlace(
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][2]["name"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][2]["weekday"].toString()
                        : "",
                    listAbout.isNotEmpty
                        ? listAbout[0]["place_list"][2]["weekend"].toString()
                        : "",
                  ),
                ],
              ),
            ),
            sectionAboutUs(),
            sectionLatestNews(),
            sectionContact(),
          ],
        ),
      ),
    );
  }

  carouselEvent() {
    return CarouselSlider.builder(
      itemCount: listEvent.length > 4 ? 4 : listEvent.length,
      itemBuilder: itemBuilderCarouselEvent,
      options: CarouselOptions(
        autoPlay: true,
        // pageSnapping: true,
        // reverse: true,
        onPageChanged: carouselChanged,
        height: MediaQuery.of(context).size.height / 2.5,
        // enlargeCenterPage: false,
      ),
    );
  }

  @override
  onErrorEventData(error) {
    print(error.toString());
  }

  @override
  onSuccessEventData(List<DocumentSnapshot> value) {
    setState(() {
      listEvent = value.reversed.toList();
      loadingEvent = false;
    });
  }

  Widget itemBuilderCarouselEvent(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: loadingEvent
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              ),
            )
          : Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    listEvent[index].data["image"],
                  ),
                ),
                // fit: BoxFit.fill,
              ],
            ),
    );
  }

  carouselChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      carouselIndex = index;
    });
  }

  List<Widget> dotWidget() {
    List<Widget> list = List<Widget>();
    int listLength;
    listEvent.length > 4 ? listLength = 4 : listLength = listEvent.length;
    for (int i = 0; i < listLength; i++) {
      list.add(Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color:
                i == carouselIndex ? Constants.blueColor : Constants.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        width: i == carouselIndex ? 25 : 12,
        height: 12,
      ));
    }
    return list;
  }

  @override
  onErrorAboutData(error) {
    print(error.toString());
  }

  @override
  onSuccessAboutData(List<DocumentSnapshot> value) {
    setState(() {
      listAbout = value;
      currentPosition = LatLng(double.parse(listAbout[0].data["maps"]["lat"]),
          double.parse(listAbout[0].data["maps"]["long"]));
      loadingAbout = false;
    });
    markers.add(
      Marker(
        markerId: MarkerId("-6.318920, 106.852008"),
        position: currentPosition,
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          if (showMapInfo) {
            setState(() {
              showMapInfo = false;
            });
          } else {
            setState(() {
              showMapInfo = true;
            });
          }
        },
      ),
    );
  }

  sectionAboutUs() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      color: Constants.blueColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tentang Kami",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Constants.whiteColor,
                  ),
                  textAlign: TextAlign.left,
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailAbout();
                    }));
                  },
                  child: Text(
                    "Selengkapnya",
                    style: TextStyle(
                      color: Constants.whiteColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.greyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: listAbout.isNotEmpty
                    ? SizedBox.expand(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FittedBox(
                            child: Image.network(
                              listAbout[0]["image"].toString(),
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : CircularProgressIndicator(
                        backgroundColor: Constants.whiteColor,
                      ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 40),
              child: loadingDoctor
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Constants.whiteColor,
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: itemBuilderDoctor,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilderDoctor(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox.expand(
                child: ClipRRect(
                  child: FittedBox(
                    child: Image.network(listDoctor[index].data['image']),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                listDoctor[index].data['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: Text(
                listDoctor[index].data['specialist'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sectionLatestNews() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: 40,
              right: 20,
              left: 20,
            ),
            child: Text(
              "Berita Terbaru",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Constants.blackColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 40),
              child: loadingNews
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Constants.blueColor,
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                        itemCount: listEvent.length > 5 ? 5 : listEvent.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: itemBuilderLatestNews,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilderLatestNews(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 1.8,
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Constants.greyColor,
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailContent(
                        type: "Event",
                        dataContent: listEvent[index],
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(listEvent[index].data['image']),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                listEvent[index].data['title'],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: Text(
                listEvent[index].data['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  sectionContact() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
            ),
            child: Text(
              "Kontak & Pengaduan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Constants.blackColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 20,
                right: 20,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton.icon(
                      icon: Icon(
                        Icons.place_outlined,
                        color: Constants.greyColor,
                      ),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listAbout.isNotEmpty
                                ? listAbout[0]["place_list"][0]["name"].toString()
                                : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            listAbout.isNotEmpty
                                ? listAbout[0]["place_list"][0]["address"].toString()
                                : "",
                            style: TextStyle(
                              color: Constants.greyColor,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        await launch(
                            'https://www.google.com/maps/search/?api=1&query=${listAbout[0]["maps"]['lat']}, ${listAbout[0]["maps"]['long']}');
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.email_outlined,
                        color: Constants.greyColor,
                      ),
                      label: Text(
                        listAbout.isNotEmpty
                            ? listAbout[0]["contact"]["email"].toString()
                            : "",
                        style: TextStyle(
                          color: Constants.greyColor,
                        ),
                      ),
                      onPressed: () async {
                        await launch("mailto:info@smk.dev");
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton.icon(
                          icon: Icon(
                            Icons.phone,
                            color: Constants.greyColor,
                          ),
                          label: Text(
                            listAbout.isNotEmpty
                                ? listAbout[0]["contact"]["phone"].toString()
                                : "",
                            style: TextStyle(
                              color: Constants.greyColor,
                            ),
                          ),
                          onPressed: () async {
                            await launch(
                                listAbout.isNotEmpty
                                ? "tel:${listAbout[0]["contact"]["phone"].toString()}"
                                : ""
                            );
                          },
                        ),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.apartment,
                            color: Constants.greyColor,
                          ),
                          label: Text(
                            listAbout.isNotEmpty
                                ? listAbout[0]["contact"]["second_phone"].toString()
                                : "",
                            style: TextStyle(
                              color: Constants.greyColor,
                            ),
                          ),
                          onPressed: () async {
                            await launch(
                                listAbout.isNotEmpty
                                    ? "tel:${listAbout[0]["contact"]["second_phone"].toString()}"
                                    : ""
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> requestPermission() async {
    await Permission.location.request();
  }

  firstAndSecondPlace(
      String name, String address, String weekday, String weekend) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        Text(
          address,
        ),
        Text(
          weekday,
        ),
        Text(
          weekend,
        ),
      ],
    );
  }

  thirdPlace(String name, String weekday, String weekend) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        Text(
          weekday,
        ),
        Text(
          weekend,
        ),
      ],
    );
  }

  @override
  onErrorDoctorData(error) {
    // TODO: implement onErrorDoctorData
    throw UnimplementedError();
  }

  @override
  onSuccessDoctorData(List<DocumentSnapshot> value) {
    setState(() {
      listDoctor = value;
      loadingDoctor = false;
    });
  }

  @override
  onErrorNewsData(error) {
    // TODO: implement onErrorNewsData
    throw UnimplementedError();
  }

  @override
  onSuccessNewsData(List<DocumentSnapshot> value) {
    setState(() {
      listNews = value;
      loadingNews = false;
    });
  }
}
