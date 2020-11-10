import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/contract/career_contract.dart';
import 'package:healthish/contract/partner_contract.dart';
import 'package:healthish/detail_screen/detail_event.dart';
import 'package:healthish/detail_screen/partner_career/component/item_career.dart';
import 'package:healthish/detail_screen/partner_career/component/item_partner.dart';
import 'package:healthish/presenter/career_presenter.dart';
import 'package:healthish/presenter/partner_presenter.dart';
import '../../constants.dart';

class PartnerCareer extends StatefulWidget {
  @override
  PartnerCareerState createState() => PartnerCareerState();
}

class PartnerCareerState extends State<PartnerCareer>
    implements PartnerContractView, CareerContractView {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> partnerData = List<DocumentSnapshot>();
  List<DocumentSnapshot> carrerData = List<DocumentSnapshot>();

  PartnerPresenter partnerPresenter;
  CareerPresenter careerPresenter;
  bool isLoadingPartner = true;
  bool isloadingCarrer = true;

  PartnerCareerState() {
    partnerPresenter = PartnerPresenter(this);
    careerPresenter = CareerPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    partnerPresenter.loadPartnerData();
    careerPresenter.loadCareer();
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
            "Patner & Career",
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
          mainAxisSize: MainAxisSize.min,
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
                  hintText: 'Search lowongan',
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
              ),
            ),
            Container(
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
                      "Patner",
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
                      child: isLoadingPartner
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Constants.blueColor,
                              ),
                            )
                          : Container(
                              child: ListView.builder(
                                itemCount: partnerData.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailEvent(
                                                  imgUrl: partnerData[index]
                                                      ['image'],
                                                  title: partnerData[index]
                                                      ['title'],
                                                  type: "career",
                                                  desc: partnerData[index]
                                                      ['description'],
                                                  date: "",
                                                )));
                                  },
                                  child: ItemPartner(
                                      image: partnerData[index]['image']),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: Text(
                "Lowongan",
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
                child: isloadingCarrer
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Constants.blueColor,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: carrerData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailEvent(
                                        date: carrerData[index]["date"],
                                        imgUrl: carrerData[index]['image'],
                                        title: carrerData[index]['title'],
                                        type: "career",
                                        desc: carrerData[index]['description'],
                                      )));
                            },
                            child: ItemCareer(carrerData: carrerData[index]),
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  @override
  onSuccesPartnerData(List<DocumentSnapshot> value) {
    setState(() {
      partnerData = value;
      isLoadingPartner = false;
    });
  }

  @override
  onSuccessCareerData(List<DocumentSnapshot> value) {
    setState(() {
      carrerData = value;
      isloadingCarrer = false;
    });
  }

  @override
  onErrorCareerData(error) {
    // TODO: implement onErrorCarrerData
    print("Error Carrer data : $error");
  }

  @override
  onErrorPartnerData(error) {
    // TODO: implement onErrorPartnerData
    throw UnimplementedError();
  }
}
