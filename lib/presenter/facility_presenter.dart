import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/contract/facility_contract.dart';

class FacilityPresenter implements FacilityContractPresenter {
  Firestore firestore = Firestore.instance;
  FacilityContractView facilityContractView;

  FacilityPresenter(this.facilityContractView);

  @override
  Future<List<DocumentSnapshot>> getFacilityData({String searchValue}) async {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      QuerySnapshot querySnapshot = await firestore
          .collection(Constants.facilityCollections)
          .getDocuments();
      return querySnapshot.documents;
    }
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.facilityCollections)
        .where(
          "title",
          isEqualTo: searchValue,
        )
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadFacilityData({String searchValue}) {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      getFacilityData()
          .then((value) => facilityContractView.onSuccessFacilityData(value))
          .catchError(
              (error) => facilityContractView.onErrorFacilityData(error));
    } else {
      getFacilityData(searchValue: searchValue)
          .then((value) => facilityContractView.onSuccessFacilityData(value))
          .catchError(
              (error) => facilityContractView.onErrorFacilityData(error));
    }
  }
}
