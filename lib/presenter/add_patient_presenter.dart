import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/add_patient_contract.dart';
import 'package:healthish/helper/constants.dart';

class AddPatientPresenter implements AddPatientContractPresenter {
  AddPatientContractView addPatientContractView;

  AddPatientPresenter(this.addPatientContractView);

  @override
  Future<String> getAddPatientData(
      String idUser, String name, String gender, String status) async {
    CollectionReference collectionReference =
        Firestore.instance.collection(Constants.patientCollections);
    DocumentReference documentReference =
        await collectionReference.add(<String, dynamic>{
      'gender': gender,
      'id_user': idUser,
      'name': name,
      'status': status,
    });
    if (documentReference.documentID != null) {
      return Constants.SUCCESS_RESPONSE;
    }
    return Constants.FAILED_RESPONSE;
  }

  @override
  loadAddPatientData(String idUser, String name, String gender, String status) {
    getAddPatientData(idUser, name, gender, status)
        .then((value) => addPatientContractView.onSuccessAddPatient(value))
        .catchError((error) => addPatientContractView.onErrorAddPatient(error));
  }
}
