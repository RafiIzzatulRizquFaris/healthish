import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/contract/partner_contract.dart';

import 'package:healthish/detail_screen/partner_career/component/item_partner.dart';
import 'package:healthish/presenter/partner_presenter.dart';

import '../../constants.dart';

class PartnerCareer extends StatefulWidget {
  @override
  PartnerCareerState createState() => PartnerCareerState();
}

class PartnerCareerState extends State<PartnerCareer>
    implements PartnerContractView {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> partnerdata = List<DocumentSnapshot>();
  bool isLoadingPartner = true;

  PartnerPresenter partnerPresenter;
  PartnerCareerState() {
    partnerPresenter = PartnerPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    partnerPresenter.loadPartnerData();
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
            "Patner & Carrer",
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
                                itemCount: partnerdata.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    ItemPartner(image: partnerdata[index]['image']),
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
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
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

  @override
  onError() {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  onSuccesPartnerData(List<DocumentSnapshot> value) {
    setState(() {
      partnerdata = value;
      isLoadingPartner = false;
    });
  }
}
