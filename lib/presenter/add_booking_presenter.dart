import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/add_booking_contract.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddBookingPresenter implements AddBookingContractPresenter {
  AddBookingContractView addBookingContractView;
  Firestore firestore = Firestore.instance;

  AddBookingPresenter(this.addBookingContractView);

  @override
  Future<List<String>> getAddBookingData(
      String idUser,
      String idDoctor,
      String idPatient,
      String date,
      String day,
      String time,
      String createAt,
      String message,
      String type) async {
    String dateNow = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String timeNow = DateFormat('HH:mm').format(DateTime.now());
    List<String> splitTime = timeNow.split(':');
    List<String> splitDate = dateNow.split('-');
    String codeBooking = "B${splitTime[0].trim()}${splitTime[1].trim()}${splitDate[0].trim()}${splitDate[1].trim()}20";
    CollectionReference collectionReference =
    firestore.collection(Constants.bookingCollections);
    DocumentReference documentReference =
    await collectionReference.add(<String, dynamic>{
      'code': codeBooking.trim(),
      'date': date,
      'day': day,
      'doctor_id': idDoctor,
      'message': message,
      'patient_id': idPatient,
      'time': time,
      'type': type,
      'create_at' : createAt,
      'user_id': idUser,
      'read': "unread",
    });
    if (documentReference.documentID != null) {
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAhyxqd3Q:APA91bGwqwpgQsUDY_KmdTF5LJtC9rOJvyf1x4sMnj4Z_SiG-j7tHv7qiJggrhXwHQVVFfMXJ4azw5uYqqonnkeaiC3IZHC29tvQcG-V3b_0Yz9oezo_TYFKgRk8hb-muMOr2h3PrpMS',
        },
        body: jsonEncode(
          <String, dynamic>{
            "notification": <String, dynamic>{
              "body": "Booking Sukses!",
              "title": "Kode Booking : $codeBooking"
            },
            "priority": "high",
            "to": "/topics/$idUser"
          },
        ),
      );
      return [Constants.SUCCESS_RESPONSE, codeBooking.trim()];
    }
    return [Constants.FAILED_RESPONSE];
  }

  @override
  loadAddBookingData(
      String idUser,
      String idDoctor,
      String idPatient,
      String date,
      String day,
      String time,
      String createAt,
      String message,
      String type) {
    getAddBookingData(
            idUser, idDoctor, idPatient, date, day, time, createAt,message, type)
        .then((value) => addBookingContractView.onSuccessAddBooking(value))
        .catchError((error) => addBookingContractView.onErrorAddBooking(error));
  }
}
