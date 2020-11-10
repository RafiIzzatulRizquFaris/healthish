import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/patient_contract.dart';

class PatientPresenter implements PatientContractPresenter {
  PatientContractView patientContractView;
  Firestore firestore = Firestore.instance;

  PatientPresenter(this.patientContractView);

  @override
  Future<List<DocumentSnapshot>> getPatientData(String id) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.patientCollections)
        .where(
          "id_user",
          isEqualTo: id,
        )
        .getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadPatientData(String id) {
    getPatientData(id)
        .then((value) => patientContractView.onSuccessPatientData(value))
        .catchError((error) => patientContractView.onErrorPatientData(error));
  }
}
