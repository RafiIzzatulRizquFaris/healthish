import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/contract/facility_contract.dart';
import 'package:healthish/detail_screen/detail_event.dart';
import 'package:healthish/detail_screen/detail_facility.dart';
import 'package:healthish/detail_screen/detail_search.dart';
import 'package:healthish/presenter/event_presenter.dart';
import 'package:healthish/presenter/facility_presenter.dart';

class Layanan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LayananState();
  }
}

class LayananState extends State<Layanan>
    implements EventContractView, FacilityContractView {
  TextEditingController searchController = TextEditingController();
  EventPresenter eventPresenter;
  FacilityPresenter facilityPresenter;
  List<DocumentSnapshot> listEvent = List<DocumentSnapshot>();
  List<DocumentSnapshot> listFacility = List<DocumentSnapshot>();
  bool loadingEvent = true;
  bool loadingFacility = true;

  LayananState() {
    eventPresenter = EventPresenter(this);
    facilityPresenter = FacilityPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    eventPresenter.loadEventData();
    facilityPresenter.loadFacilityData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Text(
            "Layanan",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w800,
              fontSize: 32,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: searchController,
                style: TextStyle(
                  color: Constants.blackColor,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Constants.whiteColor,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Constants.greyColor,
                  ),
                  hintText: 'Search dokter, fasilitas, layanan',
                  hintStyle: TextStyle(
                    color: Constants.greyColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Constants.greyColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Constants.greyColor,
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DetailSearch(value);
                  }));
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
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
                      "Fasilitas & Layanan Terkini",
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
                          top: 30, left: 10, right: 20, bottom: 40),
                      child: Container(
                        child: loadingFacility
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Constants.blueColor,
                                ),
                              )
                            : ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: itemBuilderFacility,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                  ),
                  child: Text(
                    "Event & Promo",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Constants.blackColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  child: Container(
                    child: loadingEvent
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Constants.blueColor,
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: eventPromoWidget(),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilderFacility(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Constants.greyColor,
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return DetailFacility(
              desc: listFacility[index]['description'],
              imgUrl: listFacility[index]['image'],
              title: listFacility[index]['title'],
            );
          }));
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(listFacility[index]['image']),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
              child: Text(
                listFacility[index]['title'],
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Constants.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> eventPromoWidget() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listEvent.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(
          bottom: 15,
        ),
        height: MediaQuery.of(context).size.height / 3.3,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailEvent(
                desc: listEvent[i].data["description"].toString(),
                title: listEvent[i].data["title"].toString(),
                date: listEvent[i].data["date"].toString(),
                imgUrl: listEvent[i].data["image"].toString(),
                type: listEvent[i].data["type"].toString(),
              );
            }));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox.expand(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(listEvent[i]['image']),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: 8,
                ),
                child: Text(
                  listEvent[i]['type'],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Constants.blueColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  listEvent[i]['title'],
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
                  listEvent[i]['date'],
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  @override
  onErrorEventData(error) {
    // TODO: implement onErrorEventData
    throw UnimplementedError();
  }

  @override
  onSuccessEventData(List<DocumentSnapshot> value) {
    setState(() {
      listEvent = value;
      loadingEvent = false;
    });
  }

  @override
  onErrorFacilityData(error) {
    // TODO: implement onErrorFacilityData
    throw UnimplementedError();
  }

  @override
  onSuccessFacilityData(List<DocumentSnapshot> value) {
    setState(() {
      listFacility = value;
      loadingFacility = false;
    });
  }
}
