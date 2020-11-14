import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/contract/change_status_history_contract.dart';
import 'package:healthish/presenter/change_status_history_presenter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class DetailControl extends StatefulWidget {
  final DocumentSnapshot dataBook;

  DetailControl({this.dataBook});

  @override
  DetailControlState createState() => DetailControlState();
}

class DetailControlState extends State<DetailControl>
    implements ChangeStatusHistoryContractView {
  Constants constants = Constants();
  ChangeStatusHistoryPresenter changeStatusHistoryPresenter;
  String desc =
      "Amet - minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit";
  String date;
  bool isRead = true;
  String placeName = "Not Available";
  String placeAddress = "Not Available";

  DetailControlState() {
    changeStatusHistoryPresenter = ChangeStatusHistoryPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    date = widget.dataBook['date'].toString();
    if (widget.dataBook['read'] == 'unread') {
      isRead = false;
    } else {
      isRead = true;
    }
    getNameAndAddress(
        widget.dataBook.data['doctor_id'], widget.dataBook.data['day']);
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
                "Detail",
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.dataBook['type'],
                style: TextStyle(color: Constants.blueColor, fontSize: 16),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Kode : ${widget.dataBook['code']}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                DateFormat("dd MMM yyyy", 'in_ID').format(DateTime(
                  int.parse(date.split('-')[0].toString()),
                  int.parse(date.split('-')[1].toString()),
                  int.parse(date.split('-')[2].toString()),
                )),
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.dataBook['day']},"),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.dataBook['time'],
                        style:
                            TextStyle(color: Constants.blueColor, fontSize: 24),
                      )
                    ],
                  ),
                  Container(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        width: 40,
                      )),
                  Icon(Icons.location_on_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placeName,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        placeAddress,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                widget.dataBook['message'].trim().length == 0
                    ? desc
                    : widget.dataBook['message'].trim(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Constants.whiteColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: 18,
            left: 14,
            bottom: 14,
            right: 14,
          ),
          child: FlatButton(
            padding: EdgeInsets.all(12),
            textColor: Constants.darkGreyColor,
            color: Constants.greyColorTab,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () async {
              await constants.progressDialog(context).show();
              changeStatusHistoryPresenter.loadStatusHistoryData(
                  widget.dataBook.documentID,
                  widget.dataBook['read'] == 'unread' ? true : false);
            },
            child: Text(
              isRead ? "Tandai Belum Dibaca" : "Tandai Sudah Dibaca",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  onErrorChangeStatus(error) async {
    print(error.toString());
    await constants.progressDialog(context).hide();
    constants.errorAlert(
        "Error", "Gagal merubah status. \n Sesuatu terjadi", context);
  }

  @override
  onSuccessChangeStatus(String response) async {
    if (response == Constants.SUCCESS_RESPONSE) {
      await constants.progressDialog(context).hide();
      setState(() {
        if (isRead) {
          isRead = true;
        } else {
          isRead = false;
        }
      });
    }
  }

  getNameAndAddress(String idDoctor, String day) async {
    var document = Firestore.instance
        .collection(Constants.doctorCollections)
        .document(idDoctor);
    document.get().then((value) {
      if (value.exists) {
        for (int i = 0; i < 3; i++) {
          if (value.data['schedule'][i]['day'].toString() == day) {
            setState(() {
              placeName = value.data['schedule'][i]['place'].toString();
              if (placeName == "RS. SMKDEV") {
                placeAddress = "Jl. Margacinta No. 29";
              } else {
                placeAddress = "Jl. Mars Barat I No. 9";
              }
            });
          }
        }
      }
    });
  }
}
