import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/about_contract.dart';
import 'package:healthish/detail_screen/about/title_section_about_widget.dart';
import 'package:healthish/presenter/about_presenter.dart';

class DetailAbout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailAboutState();
  }
}

class DetailAboutState extends State<DetailAbout> implements AboutContractView {
  AboutPresenter aboutPresenter;
  bool loadingAbout = true;
  List<DocumentSnapshot> listAbout = List<DocumentSnapshot>();

  List<String> listTitle = [
    "Temui Kami",
    "Layanan Darurat",
    "Waktu Operasional"
  ];
  List<String> listImage = [
    "assets/place.png",
    "assets/facility.png",
    "assets/time.png"
  ];

  DetailAboutState() {
    aboutPresenter = AboutPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    aboutPresenter.loadAboutData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Constants.blackColor,
                  size: 28,
                ),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Tentang Kami",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: loadingAbout
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      color: Constants.greyColor,
                    ),
                    child: SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(listAbout[0]['image']),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Text(
                      "Sekilas tentang SMKDEV",
                      style: TextStyle(
                        fontSize: 16,
                        color: Constants.blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Text(
                      listAbout[0]['description'].toString().replaceAll("\\n", "\n"),
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Column(
                      children: infoSectionList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> placeList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < 2; i++) {
      list.add(Container(
        alignment: Alignment.center,
        padding: i != 0 ? EdgeInsets.only(top: 15) : EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Text(
              listAbout[0]["place_list"][i]["name"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(listAbout[0]["place_list"][i]["address"]),
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> facilityList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < 3; i++) {
      list.add(Container(
        alignment: Alignment.center,
        padding: i != 0 ? EdgeInsets.only(top: 15) : EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Text(
              listAbout[0]["contact"]["phone_list"][i]["name"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            i == 0
                ? Text(listAbout[0]["ugd_schedule"])
                : i == 1
                    ? Column(
                        children: ambulanceNumberList(),
                      )
                    : Text(
              listAbout[0]["contact"]["phone_list"][2]["number"],
                      ),
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> infoSectionList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < 3; i++) {
      list.add(Column(
        children: [
          TitleSection(listImage[i], listTitle[i]),
          SizedBox(
            height: 20,
          ),
          Column(
            children: i == 0
                ? placeList()
                : i == 1
                    ? facilityList()
                    : operationalList(),
          )
        ],
      ));
    }
    return list;
  }

  List<Widget> ambulanceNumberList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listAbout[0]["contact"]["phone_list"][1]["number"].length; i++) {
      list.add(Text(listAbout[0]["contact"]["phone_list"][1]["number"][i]));
    }
    return list;
  }

  List<Widget> operationalList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listAbout[0]["place_list"].length; i++) {
      list.add(Container(
        alignment: Alignment.center,
        padding: i != 0 ? EdgeInsets.only(top: 15) : EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Text(
              listAbout[0]["place_list"][i]["name"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(listAbout[0]["place_list"][i]["weekday"]),
            Text(listAbout[0]["place_list"][i]["weekend"]),
          ],
        ),
      ));
    }
    return list;
  }

  @override
  onErrorAboutData(error) {
    // TODO: implement onErrorAboutData
    throw UnimplementedError();
  }

  @override
  onSuccessAboutData(List<DocumentSnapshot> value) {
    setState(() {
      listAbout = value;
      loadingAbout = false;
    });
  }
}
