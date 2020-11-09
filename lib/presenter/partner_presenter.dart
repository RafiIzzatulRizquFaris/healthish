import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/partner_contract.dart';

import '../constants.dart';

class PartnerPresenter implements PartnerContractPresenter {
  Firestore firestore = Firestore.instance;
  PartnerContractView patnerContractView;
  PartnerPresenter(this.patnerContractView);

  @override
  Future<List<DocumentSnapshot>> getPartnerData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection(Constants.patnerCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadPartnerData() {
    getPartnerData()
        .then((value) => patnerContractView.onSuccesPartnerData(value))
        .catchError((error) => patnerContractView.onError());
  }
}
