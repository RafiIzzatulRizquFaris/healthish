import 'package:cloud_firestore/cloud_firestore.dart';

class PatientContractView{
  onSuccessPatientData(List<DocumentSnapshot> value){}
  onErrorPatientData(error){}
}

class PatientContractPresenter{
  getPatientData(String id){}
  loadPatientData(String id){}
}