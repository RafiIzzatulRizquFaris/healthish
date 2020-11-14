import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:healthish/contract/user_contract.dart';
import 'package:healthish/helper/constants.dart';

class UserPresenter implements UserContractPresenter {
  UserContractView userContractView;
  Firestore firestore = Firestore.instance;

  UserPresenter(this.userContractView);

  @override
  Future<DocumentSnapshot> getUserData(String id) async {
    DocumentSnapshot snapshot = await firestore
        .collection(Constants.userCollections)
        .document(id)
        .get();
    return snapshot;
  }

  @override
  loadUserData(String id) {
    getUserData(id)
        .then((value) => userContractView.onSuccessUserData(value))
        .catchError((error) => userContractView.onErrorUserData(error));
  }
}
