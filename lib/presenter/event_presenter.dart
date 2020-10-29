import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/event_contract.dart';

class EventPresenter implements EventContractPresenter{

  EventContractView eventContractView;
  Firestore firestore = Firestore.instance;

  EventPresenter(this.eventContractView);

  @override
  Future<List<DocumentSnapshot>> getEventData() async {
    QuerySnapshot querySnapshot = await firestore.collection(Constants.eventCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadEventData() {
    getEventData().then((value) => eventContractView.onSuccessEventData(value)).catchError((error) => eventContractView.onErrorEventData(error));
  }

}