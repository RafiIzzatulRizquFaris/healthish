import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/detail_screen/detail_booking.dart';
import 'package:healthish/radio_group.dart';

class BookingSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingSheetState();
  }
}

class BookingSheetState extends State<BookingSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String alertRegist =
      "Maaf, anda belum terdaftar dalam aplikasi. Harap daftar terlebih dahulu untuk dapat membooking jadwal dengan dokter yang bersangkutan";
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  int radioGroupGender = -1;
  String selectedValue;
  List<RadioGroup> genderList = [
    RadioGroup(0, "Laki - Laki"),
    RadioGroup(1, "Perempuan"),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Constants.whiteColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alertRegist,
                  style: TextStyle(color: Constants.greyColorRegisterBottomSheet),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Nama",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
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
                    hintText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
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
                  height: 14,
                ),
                Text(
                  "No Handphone",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
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
                    hintText: 'No Handphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (EmailValidator.validate(value)) {
                      return null;
                    }
                    return "Email yang dimasukkan salah";
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                    color: Constants.greyColorRegisterBottomSheet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
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
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                  height: 14,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBooking()));
                          },
                          child: Text('Daftar'),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
