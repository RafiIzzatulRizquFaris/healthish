import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/register_contract.dart';
import 'package:healthish/main_navigation.dart';
import 'package:healthish/presenter/register_presenter.dart';
import 'package:healthish/radio_group.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> implements RegisterContractView {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  Constants constants = Constants();
  RegisterPresenter registerPresenter;
  bool obscureText = true;
  int radioGroupGender = -1;
  String selectedValue;
  List<RadioGroup> genderList = [
    RadioGroup(0, "Laki - Laki"),
    RadioGroup(1, "Perempuan"),
  ];

  RegisterState() {
    registerPresenter = RegisterPresenter(this);
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
              "Bermasalah dengan login?",
              style: TextStyle(
                fontSize: 16,
                color: Constants.darkGreyColor,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              Text(
                "Buat Akun",
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
                "Masukkan data diri anda untuk mendaftar",
                style: TextStyle(
                  color: Constants.greyColorGuideIndicator,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Nama Lengkap",
                style: TextStyle(
                  color: Constants.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty || value.length == 0) {
                    return "Nama boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Nama",
                  prefixIcon: Icon(Icons.person_pin_outlined),
                ),
              ),
              SizedBox(
                height: 30,
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
                      obscureText ? Icons.visibility_off : Icons.visibility,
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
                height: 30,
              ),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  color: Constants.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: genderList
                    .map((e) => Row(
                          children: [
                            Radio(
                              value: e.index,
                              groupValue: radioGroupGender,
                              onChanged: (value) {
                                setState(() {
                                  radioGroupGender = value;
                                  selectedValue = e.text;
                                });
                              },
                            ),
                            Text(e.text),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nomor Telepon",
                style: TextStyle(
                  color: Constants.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Nomor telepon boleh kosong";
                  } else if (value.length < 8) {
                    return "Nomor telepon kurang dari 8 karakter";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Telepon",
                  prefixIcon: Icon(Icons.phone_outlined),
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
                  "Daftar",
                  style: TextStyle(
                    color: Constants.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    if (selectedValue.isNotEmpty ||
                        selectedValue.trim().length > 0) {
                      await constants.progressDialog(context).show();
                      registerPresenter.loadRegisterData(
                        nameController.text.trim().toString(),
                        emailController.text.trim().toString(),
                        passwordController.text.trim().toString(),
                        selectedValue.trim().toString(),
                        phoneController.text.trim().toString(),
                      );
                    } else {
                      constants.errorAlert("Gagal Mendaftarkan Akun", "Silahkan isi semua kolom isian", context);
                    }
                  } else {
                    constants.errorAlert("Gagal Mendaftarkan Akun", "Silahkan isi semua kolom isian", context);
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mempunyai akun? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.blueColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  setOnErrorRegister(error) async {
    print(error.toString());
    await constants.progressDialog(context).hide();
    constants.errorAlert(
        "Error", "Gagal Mendaftarkan Akun. \n Sesuatu Terjadi", context);
  }

  @override
  setRegisterData(String response) async {
    if (response == Constants.SUCCESS_RESPONSE) {
      await constants.progressDialog(context).hide();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigation(),
        ),
      );
    } else if (response == Constants.ALREADY_RESPONSE) {
      await constants.progressDialog(context).hide();
      constants.errorAlert("Gagal Mendaftarkan Akun", "Email yang anda gunakan sudah terdaftar\nSilahkan gunakan email lain atau Masuk", context);
    } else {
      await constants.progressDialog(context).hide();
      constants.errorAlert("Error", "Gagal Mendaftarkan Akun", context);
    }
  }
}
