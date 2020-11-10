import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/change_password_contract.dart';
import 'package:healthish/main_navigation.dart';
import 'package:healthish/presenter/change_password_presenter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAccount extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String gender;

  DetailAccount({
    this.image,
    this.name,
    this.gender,
    this.id,
  });

  @override
  State<StatefulWidget> createState() {
    return DetailAccountState();
  }
}

class DetailAccountState extends State<DetailAccount>
    implements ChangePasswordContractView {
  final formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Constants constants = Constants();
  bool obscureText = true;
  ChangePasswordPresenter changePasswordPresenter;


  DetailAccountState() {
    changePasswordPresenter = ChangePasswordPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.arrow_back,
                  color: Constants.blackColor,
                ),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Pengaturan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Constants.greyColor,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(widget.image),
                  ),
                ),
              ),
            ),
            title: Text(
              widget.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            subtitle: Text(
              widget.gender,
              style: TextStyle(color: Constants.greyColor),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Text("Akun"),
          ),
          ListTile(
            leading: Icon(
              Icons.lock_outline_rounded,
              color: Constants.blackColor,
            ),
            title: Text(
              "Ganti Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Constants.blackColor,
            ),
            onTap: () => showBottomSheetPassword(context),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_outlined,
              color: Constants.blackColor,
            ),
            title: Text(
              "Keluar Akun",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Constants.blackColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Constants.blackColor,
            ),
            onTap: () {
              Alert(
                context: context,
                title: "Keluar Akun",
                desc: "Apakah anda yakin untuk mengeluarkan akun?",
                type: AlertType.info,
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Batal",
                      style:
                          TextStyle(color: Constants.whiteColor, fontSize: 20),
                    ),
                    color: Colors.grey,
                  ),
                  DialogButton(
                    onPressed: () async {
                      await constants.progressDialog(context).show();
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      await constants.progressDialog(context).hide();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainNavigation(),
                        ),
                      );
                    },
                    child: Text(
                      "Setuju",
                      style: TextStyle(
                        color: Constants.whiteColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
                style: AlertStyle(
                  animationType: AnimationType.grow,
                  isCloseButton: false,
                  isOverlayTapDismiss: false,
                  descStyle: TextStyle(fontWeight: FontWeight.bold),
                  descTextAlign: TextAlign.center,
                  animationDuration: Duration(milliseconds: 400),
                  alertBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  titleStyle: TextStyle(
                    color: Constants.blueColor,
                  ),
                  alertAlignment: Alignment.center,
                ),
              ).show();
            },
          ),
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.bottomCenter,
            child: Text("Healthish V1.0"),
          ),
        ],
      ),
    );
  }

  void showBottomSheetPassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Ganti Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Constants.blueColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password tidak boleh kosong";
                          } else if (value.length < 8) {
                            return "Password kurang dari 8 karakter";
                          }
                          return null;
                        },
                        controller: newPasswordController,
                        style: TextStyle(
                          color: Constants.blueColor,
                        ),
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "Password Baru",
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password tidak boleh kosong";
                          } else if (value.length < 8) {
                            return "Password kurang dari 8 karakter";
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Constants.blueColor,
                        ),
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "Konfirmasi Password",
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      right: 50,
                      left: 50,
                    ),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Constants.blueColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            if (newPasswordController.text.toString().trim() ==
                                confirmPasswordController.text
                                    .toString()
                                    .trim()) {
                              await constants.progressDialog(context).show();
                              changePasswordPresenter.loadPasswordData(
                                  id: widget.id,
                                  password: newPasswordController.text
                                      .trim()
                                      .toString());
                            } else {
                              constants.errorAlert("Gagal Memperbarui Password",
                                  "Password baru dan konfimasi password tidak sama", context);
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Konfirmasi",
                              style: TextStyle(
                                color: Constants.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  onErrorChangePassword(error) async {
    print(error.toString());
    await constants.progressDialog(context).hide();
    constants.errorAlert("Error", "Gagal merubah password. \n Sesuatu terjadi", context);
  }

  @override
  onSuccessChangePassword(String response) async {
    if (response == Constants.SUCCESS_RESPONSE) {
      await constants.progressDialog(context).hide();
      constants.successAlert("Sukses", "Anda berhasil mengubah password", context);
    } else {
      await constants.progressDialog(context).hide();
      constants.errorAlert("Error", "Gagal merubah password", context);
    }
  }
}
