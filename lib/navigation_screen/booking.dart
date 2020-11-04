import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/doctor_contract.dart';
import 'package:healthish/detail_screen/detail_doctor/detail_doctor.dart';
import 'package:healthish/presenter/doctor_presenter.dart';

class Booking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingState();
  }
}

class BookingState extends State<Booking> implements DoctorContractView {
  DoctorPresenter doctorPresenter;
  List<DocumentSnapshot> listDoctor = List<DocumentSnapshot>();
  bool loadingDoctor = true;

  BookingState() {
    doctorPresenter = DoctorPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    doctorPresenter.loadDoctorData();
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
            "Booking",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w800,
              fontSize: 32,
            ),
          ),
        ),
      ),
      body: loadingDoctor
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              ),
            )
          : ListView.builder(
              itemCount: listDoctor.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailDoctor())),
                  child: itemBuilderDoctor(context, index),
                );
              },
            ),
    );
  }

  Widget itemBuilderDoctor(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Constants.greyColor,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
          ),
          child: Expanded(
            child: SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(1000)),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(listDoctor[index]['image']),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          listDoctor[index]['name'],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Constants.blackColor),
        ),
        subtitle: Text(
          listDoctor[index]['specialist'],
          style: TextStyle(color: Constants.greyColor),
        ),
      ),
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
}
