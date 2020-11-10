class ChangePasswordContractView{
  onSuccessChangePassword(String response){}
  onErrorChangePassword(error){}
}

class ChangePasswordContractPresenter{
  getPasswordData(String id, String password){}
  loadPasswordData({String id, String password}){}
}