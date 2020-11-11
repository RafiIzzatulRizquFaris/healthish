import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/add_booking_contract.dart';

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
      String message,
      String type) async {
    List<String> splitTime = time.split(':');
    List<String> splitDate = date.split('-');
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
      'user_id': idUser,
    });
    if (documentReference.documentID != null) {
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
      String message,
      String type) {
    getAddBookingData(
            idUser, idDoctor, idPatient, date, day, time, message, type)
        .then((value) => addBookingContractView.onSuccessAddBooking(value))
        .catchError((error) => addBookingContractView.onErrorAddBooking(error));
  }
}
