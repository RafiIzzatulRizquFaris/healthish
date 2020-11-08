import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/radio_group.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  int radioGroupGender = -1;
  String selectedValue;
  List<RadioGroup> genderList = [
    RadioGroup(0, "Laki - Laki"),
    RadioGroup(1, "Perempuan"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              "Bermasalah dengan registrasi?",
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
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    // TODO: masukin ke main_navigation
                  } else {
                    // TODO: error
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
                    onTap: (){
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
}
