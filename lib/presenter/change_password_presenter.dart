import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/change_password_contract.dart';

import '../constants.dart';

class ChangePasswordPresenter implements ChangePasswordContractPresenter {
  ChangePasswordContractView changePasswordContractView;
  Firestore firestore = Firestore.instance;

  ChangePasswordPresenter(this.changePasswordContractView);

  @override
  Future<String> getPasswordData(String id, String password) async {
    DocumentReference documentReference =
        firestore.document('${Constants.userCollections}/$id');
    firestore.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);
      if (documentSnapshot.exists) {
        await transaction.update(documentReference, <String, dynamic>{
          'password': password,
        });
      } else {
        return Constants.FAILED_RESPONSE;
      }
    });
    return Constants.SUCCESS_RESPONSE;
  }

  @override
  loadPasswordData({String id, String password}) {
    getPasswordData(id, password)
        .then((value) =>
            changePasswordContractView.onSuccessChangePassword(value))
        .catchError(
            (error) => changePasswordContractView.onErrorChangePassword(error));
  }
}
