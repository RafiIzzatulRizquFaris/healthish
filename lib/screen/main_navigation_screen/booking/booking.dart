import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/contract/doctor_contract.dart';
import 'package:healthish/presenter/doctor_presenter.dart';
import 'package:healthish/screen/detail_doctor/detail_doctor.dart';

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
  TextEditingController searchController = TextEditingController();

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
                  hintText: 'Cari Dokter',
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
                  setState(() {
                    loadingDoctor = true;
                  });
                  doctorPresenter.loadDoctorData(searchValue: value,);
                },
              ),
            ),
            loadingDoctor
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Constants.blueColor,
                    ),
                  )
                : listDoctor.isEmpty
                    ? Center(
                        child: Text("Data Tidak Ditemukan"),
                      )
                    : Column(
                        children: listItemDoctor(),
                      )
          ],
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

  List<Widget> listItemDoctor() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listDoctor.length; i++) {
      list.add(GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailDoctor(
              id: listDoctor[i].documentID.toString(),
              academy: listDoctor[i]['academy'],
              credential: listDoctor[i]['credential'],
              description: listDoctor[i]['description'],
              image: listDoctor[i]['image'],
              name: listDoctor[i]['name'],
              specialist: listDoctor[i]['specialist'],
              scheduleDay: [
                listDoctor[i]['schedule'][0]['day'],
                listDoctor[i]['schedule'][1]['day'],
                listDoctor[i]['schedule'][2]['day']
              ],
              schedulePlace: [
                listDoctor[i]['schedule'][0]['place'],
                listDoctor[i]['schedule'][1]['place'],
                listDoctor[i]['schedule'][2]['place']
              ],
              scheduleTime: [
                listDoctor[i]['schedule'][0]['time'],
                listDoctor[i]['schedule'][1]['time'],
                listDoctor[i]['schedule'][2]['time']
              ],
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Constants.greyColor,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(listDoctor[i]['image']),
                  ),
                ),
              ),
            ),
            title: Text(
              listDoctor[i]['name'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            subtitle: Text(
              listDoctor[i]['specialist'],
              style: TextStyle(color: Constants.greyColor),
            ),
          ),
        ),
      ));
    }
    return list;
  }
}
