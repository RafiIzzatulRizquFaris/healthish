import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/add_patient_contract.dart';
import 'package:healthish/presenter/add_patient_presenter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddPatientSheet extends StatefulWidget {
  final String idUser;

  AddPatientSheet({this.idUser});

  @override
  AddPatientSheetState createState() => AddPatientSheetState();
}

class AddPatientSheetState extends State<AddPatientSheet> implements AddPatientContractView {
  String dropdownValue;
  String radioValue;
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AddPatientPresenter addPatientPresenter;
  ProgressDialog loadingDialog;
  TextEditingController nameController = TextEditingController();
  int radioGroupGender = -1;

  AddPatientSheetState(){
    addPatientPresenter = AddPatientPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 50 / 100,
      child: Padding(
        padding: EdgeInsets.only(
          top: 28,
          left: 24,
          right: 24,
        ),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tambah info pasien baru",
                  style: TextStyle(
                    color: Constants.blueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text("Nama"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isNotEmpty || value.length > 0) {
                      return null;
                    }
                    return "Nama harus diisi";
                  },
                  decoration: InputDecoration(
                    hintText: 'Nama',
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text("Jenis Kelamin"),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: radioGroupGender,
                      onChanged: (value) {
                        setState(() {
                          radioGroupGender = value;
                          radioValue = "Laki - Laki";
                        });
                      },
                    ),
                    Text(
                      'Laki-laki',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 1,
                      groupValue: radioGroupGender,
                      onChanged: (value) {
                        setState(() {
                          radioGroupGender = value;
                          radioValue = "Perempuan";
                        });
                      },
                    ),
                    Text(
                      'Perempuan',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                Text("Status"),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    hint: Text("Pilih Salah Satu"),
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Saya sendiri', 'Keluarga saya']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 5,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textColor: Constants.greyColorCancel,
                          color: Constants.greyColorTab,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Batal'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 5,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textColor: Constants.whiteColor,
                          color: Constants.blueColor,
                          onPressed: () async {
                            String gender = radioValue.trim().toString();
                            String status = dropdownValue.trim().toString();
                            String name = nameController.text.trim().toString();
                            if (status.length > 0 && gender.length > 0 && formKey.currentState.validate() && name.length > 0){
                              await loadingDialog.show();
                              addPatientPresenter.loadAddPatientData(widget.idUser, name, gender, status);
                            }else{
                              errorAlert("Gagal Menambah Pasien", "Silahkan isi semua kolom pengisian");
                            }
                          },
                          child: Text('Tambah'),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  errorAlert(String title, String subtitle) {
    return Alert(
      context: context,
      title: title,
      desc: subtitle,
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
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

  @override
  onErrorAddPatient(error) async {
    print(error.toString());
    await loadingDialog.hide();
    errorAlert("Error", "Gagal menambah pasien. \n Sesuatu terjadi");
  }

  @override
  onSuccessAddPatient(String status) async {
    if (status == Constants.SUCCESS_RESPONSE) {
      await loadingDialog.hide();
      Alert(
        context: context,
        title: "Sukses",
        desc: "Anda berhasil menambah daftar pasien",
        type: AlertType.success,
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
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
    } else {
      await loadingDialog.hide();
      errorAlert("Error", "Gagal menambah pasien");
    }
  }
}
