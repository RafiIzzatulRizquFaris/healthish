import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/booking_contract.dart';

import '../constants.dart';

class BookingPresenter implements BookingContactPresenter {
  BookingCOntractView bookingContractView;
  BookingPresenter(this.bookingContractView);
  Firestore firestore = Firestore.instance;

  @override
  Future<List<DocumentSnapshot>> getBookingData(String userId) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.bookingCollections)
        .where("user_id", isEqualTo: userId)
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadBookingData(String userId) {
    getBookingData(userId)
        .then((value) => bookingContractView.onSuccessBooking(value))
        .catchError((error) => bookingContractView.onError(error));
  }
}
