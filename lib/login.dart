import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/login_contract.dart';
import 'package:healthish/main_navigation.dart';
import 'package:healthish/presenter/login_presenter.dart';
import 'package:healthish/register.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> implements LoginContractView {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Constants constants = Constants();
  LoginPresenter loginPresenter;
  bool obscureText = true;
  bool loadingLogin = false;

  LoginState() {
    loginPresenter = LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: FlatButton(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Constants.whiteColor,
            size: 25,
          ),
          shape: CircleBorder(),
          color: Constants.greyColorGuideIndicator,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          FlatButton(
            child: Text(
              "Bermasalah dengan Login?",
              style: TextStyle(
                fontSize: 16,
                color: Constants.darkGreyColor,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: loadingLogin
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              ),
            )
          : Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: ListView(
                  children: [
                    Text(
                      "Selamat Datang!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Constants.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Masukkan data login anda untuk melanjutkan",
                      style: TextStyle(
                        color: Constants.greyColorGuideIndicator,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Constants.blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                      validator: (value) {
                        if (EmailValidator.validate(value)) {
                          return null;
                        }
                        return "Email yang dimasukkan salah";
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Constants.blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscureText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password tidak boleh kosong";
                        } else if (value.length < 8) {
                          return "Password kurang dari 8 karakter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            if (obscureText) {
                              setState(() {
                                obscureText = false;
                              });
                            } else {
                              setState(() {
                                obscureText = true;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Constants.blueColor,
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                          color: Constants.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            loadingLogin = true;
                          });
                          loginPresenter.loadLoginData(
                              emailController.text.toString(),
                              passwordController.text.toString());
                        } else {
                          // TODO: error
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum mempunyai akun? ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Constants.blueColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Register();
                              }),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  setLoginData(String response) {
    if (response == Constants.SUCCESS_RESPONSE) {
      setState(() {
        loadingLogin = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainNavigation();
      }));
    } else if (response == Constants.WRONG_PASSWORD_RESPONSE) {
      setState(() {
        loadingLogin = false;
      });
      constants.errorAlert("Gagal Login", "Password yang anda masukkan salah", context);
    } else {
      constants.errorAlert("Gagal Login", "Akun Anda Tidak Terdaftar", context);
    }
  }

  @override
  setOnErrorLogin(error) {
    setState(() {
      loadingLogin = false;
    });
    constants.errorAlert("Gagal Login", "Cek Koneksi Internet Anda Dan Coba Kembali", context);
  }
}
