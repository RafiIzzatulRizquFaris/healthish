import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/login_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPresenter implements LoginContractPresenter {
  LoginContractView loginContractView;
  Firestore firestore = Firestore.instance;

  LoginPresenter(this.loginContractView);

  @override
  Future<String> getLoginData(String email, String password) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.userCollections)
        .where(
          "email",
          isEqualTo: email,
        )
        .getDocuments();
    if (querySnapshot.documents.length == 1) {
      String dataPassword = querySnapshot.documents[0].data['password'];
      if (password == dataPassword) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(
            Constants.KEY_ID, querySnapshot.documents[0].documentID.toString());
        await preferences.setBool(Constants.KEY_LOGIN, true);
        return Constants.SUCCESS_RESPONSE;
      } else {
        return Constants.WRONG_PASSWORD_RESPONSE;
      }
    } else {
      return Constants.FAILED_RESPONSE;
    }
  }

  @override
  loadLoginData(String email, String password) {
    getLoginData(email, password)
        .then((value) => loginContractView.setLoginData(value))
        .catchError((error) => loginContractView.setOnErrorLogin(error));
  }
}
