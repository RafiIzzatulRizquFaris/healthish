import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/doctor_contract.dart';

class DoctorPresenter implements DoctorContractPresenter {
  DoctorContractView doctorContractView;
  Firestore firestore = Firestore.instance;

  DoctorPresenter(this.doctorContractView);

  @override
  Future<List<DocumentSnapshot>> getDoctorData() async {
    QuerySnapshot querySnapshot = await firestore.collection(Constants.doctorCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadDoctorData() {
    getDoctorData()
        .then((value) => doctorContractView.onSuccessDoctorData(value))
        .catchError((error) => doctorContractView.onErrorDoctorData(error));
  }
}
