import 'package:cloud_firestore/cloud_firestore.dart';

class UserContractView{
  onSuccessUserData(DocumentSnapshot value){}
  onErrorUserData(error){}
}

class UserContractPresenter{
  getUserData(String id){}
  loadUserData(String id){}
}