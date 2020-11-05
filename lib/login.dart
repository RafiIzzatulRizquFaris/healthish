import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();

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
          onPressed: () {},
        ),
        actions: [
          FlatButton(
            child: Text(
              "Trouble Logging In?",
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
                validator: (value){
                  if (EmailValidator.validate(value)){
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
                  if (value.isEmpty){
                    return "Password tidak boleh kosong";
                  }else if (value.length < 8){
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
                    onPressed: (){
                      if(obscureText){
                        setState(() {
                          obscureText = false;
                        });
                      }else{
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
                  if (formKey.currentState.validate()){
                    // TODO: masukin ke main_navigation
                  }else{
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
}