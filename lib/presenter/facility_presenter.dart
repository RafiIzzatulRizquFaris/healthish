import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/facility_contract.dart';

class FacilityPresenter implements FacilityContractPresenter {
  Firestore firestore = Firestore.instance;
  FacilityContractView facilityContractView;

  FacilityPresenter(this.facilityContractView);

  @override
  Future<List<DocumentSnapshot>> getFacilityData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection(Constants.facilityCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadFacilityData() {
    getFacilityData()
        .then((value) => facilityContractView.onSuccessFacilityData(value))
        .catchError((error) => facilityContractView.onErrorFacilityData(error));
  }
}
