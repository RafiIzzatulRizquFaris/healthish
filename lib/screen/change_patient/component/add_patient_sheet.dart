import 'package:flutter/material.dart';
import 'package:healthish/helper/constants.dart';

class AddPatientSheet extends StatefulWidget {
  AddPatientSheet({Key key}) : super(key: key);

  @override
  AddPatientSheetState createState() => AddPatientSheetState();
}

class AddPatientSheetState extends State<AddPatientSheet> {
  String dropdownValue;

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
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 24,
                ),
                Text("Nama"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
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
                      groupValue: 1,
                      onChanged: (val) {},
                    ),
                    Text(
                      'Laki-laki',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 0,
                      groupValue: 1,
                      onChanged: (val) {},
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
                    hint: Text("pilih Salah satu"),
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['saya sendiri', 'keluarga saya']
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
                          onPressed: () {},
                          child: Text('Tambah'),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            ),
          )),
    );
  }
}
