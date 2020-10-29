import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/about_contract.dart';

class AboutPresenter implements AboutContractPresenter {
  AboutContractView aboutContractView;
  Firestore firestore = Firestore.instance;

  AboutPresenter(this.aboutContractView);

  @override
  Future<List<DocumentSnapshot>> getAboutData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection(Constants.aboutCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadAboutData() {
    getAboutData()
        .then((value) => aboutContractView.onSuccessAboutData(value))
        .catchError((error) => aboutContractView.onErrorAboutData(error));
  }
}
