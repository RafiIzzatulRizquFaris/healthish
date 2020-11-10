class LoginContractView {
  setLoginData(String response) {}
  setOnErrorLogin(error) {}
}

class LoginContractPresenter {
  getLoginData (String email, String password){}
  loadLoginData (String email, String password){}
}