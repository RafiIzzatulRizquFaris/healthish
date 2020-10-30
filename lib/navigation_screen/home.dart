import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/about_contract.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/presenter/about_presenter.dart';
import 'package:healthish/presenter/event_presenter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>
    implements EventContractView, AboutContractView {
  AboutPresenter aboutPresenter;
  EventPresenter eventPresenter;
  int carouselIndex = 0;
  List<DocumentSnapshot> listEvent = List<DocumentSnapshot>();
  List<DocumentSnapshot> listAbout = List<DocumentSnapshot>();
  bool loadingEvent = true;
  bool loadingAbout = true;
  final Set<Marker> markers = {};
  LatLng currentPosition = LatLng(0.0, 0.0);

  HomeState() {
    eventPresenter = EventPresenter(this);
    aboutPresenter = AboutPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    eventPresenter.loadEventData();
    aboutPresenter.loadAboutData();
    markers.add(
      Marker(
        markerId: MarkerId("rumah sakit"),
        position: currentPosition,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: "Medical center",
          snippet: "This is medical center",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      alignment: Alignment.bottomLeft,
                      child: Container(
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
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loadingEvent
                                  ? "lorem ipsum"
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
                                  ? "lorem ipsum"
                                  : listEvent[carouselIndex]
                                      .data["description"],
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: currentPosition,
                          zoom: 14.0,
                        ),
                        markers: markers,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Place Name",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Place Address",
                      ),
                      Text(
                        "Place Weekday",
                      ),
                      Text(
                        "Place Weekend",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Place Name",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Place Address",
                      ),
                      Text(
                        "Place Weekday",
                      ),
                      Text(
                        "Place Weekend",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Place Name",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Place Weekday",
                      ),
                      Text(
                        "Place Weekend",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sectionAboutUs(),
          ],
        ),
      ),
    );
  }

  carouselEvent() {
    return CarouselSlider.builder(
      itemCount: listEvent.length,
      itemBuilder: itemBuilderCarouselEvent,
      options: CarouselOptions(
        autoPlay: true,
        pageSnapping: true,
        reverse: true,
        onPageChanged: carouselChanged,
        height: MediaQuery.of(context).size.height / 2.5,
        enlargeCenterPage: false,
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
      listEvent = value;
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
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      listEvent[index].data["image"],
                    ),
                  ),
                  // fit: BoxFit.fill,
                ),
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
    for (int i = 0; i < listEvent.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color:
                i == carouselIndex ? Constants.blueColor : Constants.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
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
  }

  sectionAboutUs() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      color: Constants.blueColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tentang Kami",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Constants.whiteColor
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Selengkapnya",
                  style: TextStyle(
                      color: Constants.whiteColor
                  ),
                  textAlign: TextAlign.left,
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 20),
              child: Container(
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
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 10,),
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: BoxDecoration(
          color: Constants.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(10),),
        ),
      ),
    );
  }
}
