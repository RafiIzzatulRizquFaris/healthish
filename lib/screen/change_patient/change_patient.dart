import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthish/contract/patient_contract.dart';
import 'package:healthish/presenter/patient_presenter.dart';
import '../../helper/constants.dart';
import 'component/add_patient_sheet.dart';

class ChangePatient extends StatefulWidget {
  final int selectedPatient;
  final String userId;

  ChangePatient({this.selectedPatient, this.userId});

  @override
  ChangePatientState createState() => ChangePatientState();
}

class ChangePatientState extends State<ChangePatient>
    implements PatientContractView {
  PatientPresenter patientPresenter;
  bool loadingPatient = true;
  List<DocumentSnapshot> listPatient = List<DocumentSnapshot>();
  int selectedValue = 0;

  ChangePatientState() {
    patientPresenter = PatientPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    patientPresenter.loadPatientData(widget.userId);
    selectedValue = widget.selectedPatient;
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
                  return Navigator.pop(context, selectedValue);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Ganti Pasien",
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
          children: [
            listPatient.length == 0
                ? Container()
                : loadingPatient
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Constants.blueColor,
                        ),
                      )
                    : Column(
                        children: listSelectedPatient(),
                      ),
            FlatButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return AddPatientSheet(
                      idUser: widget.userId,
                    );
                  },
                ).then((value) {
                  setState(() {
                    loadingPatient = true;
                    if (value != null){
                      selectedValue = value;
                    }
                  });
                  patientPresenter.loadPatientData(widget.userId);
                });
              },
              child: Text(
                "Tambah Baru",
                style: TextStyle(color: Constants.blueColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> listSelectedPatient() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listPatient.length; i++) {
      list.add(Container(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama : ${listPatient[i].data['name']}",
                    style: TextStyle(
                        color: Color(0xff8B8B8B), fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Jenis Kelamin : ${listPatient[i].data['gender']}",
                    style: TextStyle(
                        color: Color(0xff8B8B8B), fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Status : ${listPatient[i].data['status']}",
                    style: TextStyle(
                        color: Color(0xff8B8B8B), fontWeight: FontWeight.w500),
                  )
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => selectedValue = i),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: selectedValue != i
                      ? BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle)
                      : null,
                  child: selectedValue == i
                      ? Icon(
                          Icons.check_circle,
                          size: 35,
                          color: Constants.blueColor,
                        )
                      : null,
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
  onErrorPatientData(error) {
    // TODO: implement onErrorPatientData
    throw UnimplementedError();
  }

  @override
  onSuccessPatientData(List<DocumentSnapshot> value) {
    setState(() {
      listPatient = value;
      loadingPatient = false;
    });
  }
}
