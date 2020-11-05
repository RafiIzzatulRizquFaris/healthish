import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/detail_screen/title_section_about_widget.dart';

class DetailAbout extends StatefulWidget {
  final String imgUrl;
  final String desc;
  final String ugdSchedule;
  final List facilityName;
  final String ugdNumber;
  final List ambulanceNumber;
  final String phoneNumber;
  final List placeName;
  final List placeAddress;
  final List weekday;
  final List weekend;

  DetailAbout({
    this.imgUrl,
    this.desc,
    this.ugdSchedule,
    this.facilityName,
    this.ugdNumber,
    this.ambulanceNumber,
    this.phoneNumber,
    this.placeName,
    this.placeAddress,
    this.weekday,
    this.weekend,
  });

  @override
  State<StatefulWidget> createState() {
    return DetailAboutState();
  }
}

class DetailAboutState extends State<DetailAbout> {
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
      body: SingleChildScrollView(
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
                  child: Image.network(widget.imgUrl),
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
                widget.desc.replaceAll("\\n", "\n"),
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30,),
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
              widget.placeName[i],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(widget.placeAddress[i]),
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
              widget.facilityName[i],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            i == 0
                ? Text(widget.ugdSchedule)
                : i == 1
                    ? Column(
                        children: ambulanceNumberList(),
                      )
                    : Text(
                        widget.phoneNumber,
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
            children: i == 0 ? placeList() : i == 1 ? facilityList() : operationalList(),
          )
        ],
      ));
    }
    return list;
  }

  List<Widget> ambulanceNumberList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < widget.ambulanceNumber.length; i++){
      list.add(Text(widget.ambulanceNumber[i]));
    }
    return list;
  }

  List<Widget> operationalList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < widget.placeName.length; i++){
      list.add(
          Container(
            alignment: Alignment.center,
            padding: i != 0 ? EdgeInsets.only(top: 15) : EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Text(
                  widget.placeName[i],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(widget.weekday[i]),
                Text(widget.weekend[i]),
              ],
            ),
          )
      );
    }
    return list;
  }
}
