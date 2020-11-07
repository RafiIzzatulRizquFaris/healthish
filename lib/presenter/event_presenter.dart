import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/event_contract.dart';

class EventPresenter implements EventContractPresenter {
  EventContractView eventContractView;
  Firestore firestore = Firestore.instance;

  EventPresenter(this.eventContractView);

  @override
  Future<List<DocumentSnapshot>> getEventData({String searchValue}) async {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      QuerySnapshot querySnapshot =
          await firestore.collection(Constants.eventCollections).getDocuments();
      return querySnapshot.documents;
    }
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.eventCollections)
        .where(
          "title",
          isEqualTo: searchValue,
        )
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadEventData({String searchValue}) {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      getEventData()
          .then((value) => eventContractView.onSuccessEventData(value))
          .catchError((error) => eventContractView.onErrorEventData(error));
    } else {
      getEventData(searchValue: searchValue)
          .then((value) => eventContractView.onSuccessEventData(value))
          .catchError((error) => eventContractView.onErrorEventData(error));
    }
  }
}
