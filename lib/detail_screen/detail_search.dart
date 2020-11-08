import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/doctor_contract.dart';
import 'package:healthish/contract/event_contract.dart';
import 'package:healthish/contract/facility_contract.dart';
import 'package:healthish/detail_screen/detail_event.dart';
import 'package:healthish/presenter/doctor_presenter.dart';
import 'package:healthish/presenter/event_presenter.dart';
import 'package:healthish/presenter/facility_presenter.dart';

class DetailSearch extends StatefulWidget {
  final String submittedValue;

  DetailSearch(this.submittedValue);

  @override
  State<StatefulWidget> createState() {
    return DetailSearchState();
  }
}

class DetailSearchState extends State<DetailSearch>
    implements FacilityContractView, EventContractView, DoctorContractView {
  TextEditingController searchController;
  FacilityPresenter facilityPresenter;
  EventPresenter eventPresenter;
  DoctorPresenter doctorPresenter;
  bool loadingFacility = true;
  bool loadingEvent = true;
  bool loadingDoctor = true;
  List<DocumentSnapshot> listFacility = List<DocumentSnapshot>();
  List<DocumentSnapshot> listEvent = List<DocumentSnapshot>();
  List<DocumentSnapshot> listDoctor = List<DocumentSnapshot>();

  DetailSearchState() {
    facilityPresenter = FacilityPresenter(this);
    eventPresenter = EventPresenter(this);
    doctorPresenter = DoctorPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.submittedValue);
    facilityPresenter.loadFacilityData(searchValue: widget.submittedValue);
    eventPresenter.loadEventData(searchValue: widget.submittedValue);
    doctorPresenter.loadDoctorData(searchValue: widget.submittedValue);
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.arrow_back,
                  color: Constants.blackColor,
                ),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Pencarian",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
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
                onFieldSubmitted: (value) {
                  setState(() {
                    loadingDoctor = true;
                    loadingEvent = true;
                    loadingFacility = true;
                  });
                  doctorPresenter.loadDoctorData(searchValue: value);
                  eventPresenter.loadEventData(searchValue: value);
                  facilityPresenter.loadFacilityData(searchValue: value);
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
                        top: 30,
                        left: 10,
                        right: 20,
                        bottom: 40,
                      ),
                      child: Container(
                        child: loadingFacility
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Constants.blueColor,
                                ),
                              )
                            : listFacility.isEmpty
                                ? Center(
                                    child: Text("Data tidak ditemukan"),
                                  )
                                : ListView.builder(
                                    itemCount: listFacility.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: itemBuilderFacility,
                                  ),
                      ),
                    ),
                  ),
                ],
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
                      "Dokter & Tenaga Medis",
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
                        left: 10,
                        right: 20,
                        bottom: 40,
                      ),
                      child: Container(
                        child: loadingDoctor
                            ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Constants.blueColor,
                          ),
                        )
                            : listDoctor.isEmpty
                            ? Center(
                          child: Text("Data tidak ditemukan"),
                        )
                            : ListView.builder(
                          itemCount: listDoctor.length,
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
                        : listEvent.isEmpty
                            ? Center(
                                child: Text("Data tidak ditemukan"),
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
        left: 20,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecoration(
        border: Border.all(color: Constants.greyColor),
        color: Constants.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
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
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
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
  onErrorFacilityData(error) {
    // TODO: implement onErrorFacilityData
    throw UnimplementedError();
  }

  @override
  onSuccessFacilityData(List<DocumentSnapshot> value) {
    if (value.isNotEmpty || value != null || value.length > 0) {
      setState(() {
        listFacility = value;
        loadingFacility = false;
      });
    }
  }

  @override
  onErrorEventData(error) {
    // TODO: implement onErrorEventData
    throw UnimplementedError();
  }

  @override
  onSuccessEventData(List<DocumentSnapshot> value) {
    if (value.isNotEmpty || value != null || value.length > 0) {
      setState(() {
        listEvent = value;
        loadingEvent = false;
      });
    }
  }

  @override
  onErrorDoctorData(error) {
    // TODO: implement onErrorDoctorData
    throw UnimplementedError();
  }

  @override
  onSuccessDoctorData(List<DocumentSnapshot> value) {
    if (value.isNotEmpty || value != null || value.length > 0) {
      setState(() {
        listDoctor = value;
        loadingDoctor = false;
      });
    }
  }
}
