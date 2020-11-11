import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/partner_contract.dart';

import '../constants.dart';

class PartnerPresenter implements PartnerContractPresenter {
  Firestore firestore = Firestore.instance;
  PartnerContractView partnerContractView;

  PartnerPresenter(this.partnerContractView);

  @override
  Future<List<DocumentSnapshot>> getPartnerData({String searchValue}) async {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      QuerySnapshot querySnapshot = await firestore
          .collection(Constants.partnerCollections)
          .getDocuments();
      return querySnapshot.documents;
    }
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.partnerCollections)
        .where('title', isEqualTo: searchValue)
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadPartnerData({String searchValue}) {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      getPartnerData()
          .then((value) => partnerContractView.onSuccessPartnerData(value))
          .catchError((error) => partnerContractView.onErrorPartnerData(error));
    } else {
      getPartnerData(searchValue: searchValue)
          .then((value) => partnerContractView.onSuccessPartnerData(value))
          .catchError((error) => partnerContractView.onErrorPartnerData(error));
    }
  }
}
