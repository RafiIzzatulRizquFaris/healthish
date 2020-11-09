import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/career_contract.dart';

import '../constants.dart';

class CareerPresenter implements CareerContractPresenter {
  Firestore firestore = Firestore.instance;
  CareerContractView careerContractView;

  CareerPresenter(this.careerContractView);

  @override
  Future<List<DocumentSnapshot>> getCareer() async {
    QuerySnapshot querySnapshot =
        await firestore.collection(Constants.careerCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadCareer() {
    getCareer()
        .then((value) => careerContractView.onSuccessCareerData(value))
        .catchError((error) => careerContractView.onErrorCareerData(error));
  }
}
