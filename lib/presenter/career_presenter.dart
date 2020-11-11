import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/career_contract.dart';

import '../constants.dart';

class CareerPresenter implements CareerContractPresenter {
  Firestore firestore = Firestore.instance;
  CareerContractView careerContractView;

  CareerPresenter(this.careerContractView);

  @override
  Future<List<DocumentSnapshot>> getCareer({String searchValue}) async {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      QuerySnapshot querySnapshot = await firestore
          .collection(Constants.careerCollections)
          .getDocuments();
      return querySnapshot.documents;
    }
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.careerCollections)
        .where("title", isEqualTo: searchValue)
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadCareer({String searchValue}) {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      getCareer()
          .then((value) => careerContractView.onSuccessCareerData(value))
          .catchError((error) => careerContractView.onErrorCareerData(error));
    } else {
      getCareer(searchValue: searchValue)
          .then((value) => careerContractView.onSuccessCareerData(value))
          .catchError((error) => careerContractView.onErrorCareerData(error));
    }
  }
}
