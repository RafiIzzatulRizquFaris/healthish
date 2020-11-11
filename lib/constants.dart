import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Constants{

  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color darkGreyColor = Color(0xff7F7F7F);
  static const Color greyColor = Color(0xffD0D0D0);
  static const Color greyColorTab = Color(0xffF2F2F2);
  static const Color greyColorGuide = Color(0xff999999);
  static const Color greyColorGuideIndicator = Color(0xffC4C4C4);
  static const Color greyColorCancel = Color(0xff333333);
  static const Color greyColorRegisterBottomSheet = Color(0xff828282);
  static const Color blueColor = Color(0xff2962FF);
  static const Color blackColor = Color(0xff1E1E1D);
  static const Color redColor = Color(0xffFF5E20);

  static const String eventCollections = "event";
  static const String aboutCollections = "about";
  static const String doctorCollections = "doctor";
  static const String partnerCollections = "partner";
  static const String newsCollections = "news";
  static const String facilityCollections = "facility";
  static const String guideCollections = "guide";
  static const String careerCollections = "career";
  static const String userCollections = "user";
  static const String patientCollections = "patient";
  static const String bookingCollections = "booking";

  static const String KEY_GUIDE = "guide";
  static const String KEY_LOGIN = "login";
  static const String KEY_ID = "id_document";

  static const String SUCCESS_RESPONSE = "success";
  static const String FAILED_RESPONSE = "failed";
  static const String WRONG_PASSWORD_RESPONSE = "wrong";
  static const String ALREADY_RESPONSE = "already";

  ProgressDialog progressDialog(BuildContext ctx){
    ProgressDialog loadingDialog = ProgressDialog(
      ctx,
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
    return loadingDialog;
  }

  successAlert(String title, String subtitle, BuildContext ctx){
    return Alert(
      context: ctx,
      title: title,
      desc: subtitle,
      type: AlertType.success,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: Text(
            "Ok",
            style: TextStyle(color: Constants.whiteColor, fontSize: 20),
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
  }

  errorAlert(String title, String subtitle, BuildContext ctx) {
    return Alert(
      context: ctx,
      title: title,
      desc: subtitle,
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
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
          color: Colors.red,
        ),
        alertAlignment: Alignment.center,
      ),
    ).show();
  }
}