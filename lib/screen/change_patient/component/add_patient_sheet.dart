import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/contract/add_patient_contract.dart';
import 'package:healthish/presenter/add_patient_presenter.dart';

class AddPatientSheet extends StatefulWidget {
  final String idUser;

  AddPatientSheet({this.idUser});

  @override
  AddPatientSheetState createState() => AddPatientSheetState();
}

class AddPatientSheetState extends State<AddPatientSheet>
    implements AddPatientContractView {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Constants constants = Constants();
  AddPatientPresenter addPatientPresenter;
  int radioGroupGender = -1;
  String dropdownValue;
  String radioValue;

  AddPatientSheetState() {
    addPatientPresenter = AddPatientPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            if (status.length > 0 &&
                                gender.length > 0 &&
                                formKey.currentState.validate() &&
                                name.length > 0) {
                              await constants.progressDialog(context).show();
                              addPatientPresenter.loadAddPatientData(
                                  widget.idUser, name, gender, status);
                            } else {
                              constants.errorAlert("Gagal Menambah Pasien",
                                  "Silahkan isi semua kolom pengisian", context);
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

  @override
  onErrorAddPatient(error) async {
    print(error.toString());
    await constants.progressDialog(context).hide();
    constants.errorAlert(
        "Error", "Gagal menambah pasien. \n Sesuatu terjadi", context);
  }

  @override
  onSuccessAddPatient(String status) async {
    if (status == Constants.SUCCESS_RESPONSE) {
      await constants.progressDialog(context).hide();
      constants.successAlert("Sukses", "Anda berhasil menambah daftar pasien", context);
    } else {
      await constants.progressDialog(context).hide();
      constants.errorAlert("Error", "Gagal menambah pasien", context);
    }
  }
}
