import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/main_navigation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAccount extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String gender;

  DetailAccount({this.image, this.name, this.gender, this.id});

  @override
  State<StatefulWidget> createState() {
    return DetailAccountState();
  }
}

class DetailAccountState extends State<DetailAccount> {
  ProgressDialog loadingDialog;

  @override
  Widget build(BuildContext context) {
    loadingDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    loadingDialog.style(
      message: "Loading",
      progressWidget: Container(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          backgroundColor: Constants.blueColor,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: Constants.blueColor,
      ),
    );

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
                      await loadingDialog.show();
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      await loadingDialog.hide();
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
}
