import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/contract/doctor_contract.dart';

class DoctorPresenter implements DoctorContractPresenter {
  DoctorContractView doctorContractView;
  Firestore firestore = Firestore.instance;

  DoctorPresenter(this.doctorContractView);

  @override
  Future<List<DocumentSnapshot>> getDoctorData({String searchValue}) async {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      QuerySnapshot querySnapshot = await firestore.collection(
          Constants.doctorCollections).getDocuments();
      return querySnapshot.documents;
    }
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.doctorCollections)
        .where(
      "name",
      isEqualTo: searchValue,
    )
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadDoctorData({String searchValue}) {
    if (searchValue == null || searchValue.isEmpty || searchValue.length == 0) {
      getDoctorData()
          .then((value) => doctorContractView.onSuccessDoctorData(value))
          .catchError((error) => doctorContractView.onErrorDoctorData(error));
    }else{
      getDoctorData(searchValue: searchValue)
          .then((value) => doctorContractView.onSuccessDoctorData(value))
          .catchError((error) => doctorContractView.onErrorDoctorData(error));
    }
  }
}
