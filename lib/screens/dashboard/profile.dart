import 'package:diabet/services/user.dart';
import 'package:diabet/models/interface.dart';
import 'package:diabet/models/user.dart';
import 'package:diabet/services/auth.dart';
import 'package:diabet/shared/constants.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  String name = '';
  String phone = '';
  String gender = '';
  String date = '';
  String weight = '';
  String height = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: UserService(userUid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            UserData userData = snapshot.data;
            return Scaffold(
                backgroundColor: Color(0xff392850),
                appBar: AppBar(
                    backgroundColor: Color(Interface.background),
                    title: Text("Profil pengguna",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: Interface.fontSizeTitle,
                                fontWeight: FontWeight.bold)))),
                body: ListView(children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                                initialValue: userData.name,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Nama Lengkap'),
                                validator: (val) => val.isEmpty
                                    ? 'Enter an nama lengkap'
                                    : null,
                                onChanged: (val) {
                                  setState(() => name = val);
                                }),
                            SizedBox(height: 20.0),
                            TextFormField(
                                initialValue: userData.phone,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Nomor telpon'),
                                validator: (val) => val.isEmpty
                                    ? 'Enter an nomor telpon'
                                    : null,
                                onChanged: (val) {
                                  setState(() => phone = val);
                                }),
                            SizedBox(height: 20.0),
                            DropdownButtonFormField(
                                value: userData.gender,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Jenis kelamin'),
                                items: <String>[
                                  'Laki-laki',
                                  'Perempuan'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (val) {
                                  setState(() => gender = val);
                                }),
                            SizedBox(height: 20.0),
                            TextFormField(
                                initialValue: userData.birthDate,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Tanggal lahir'),
                                keyboardType: TextInputType.datetime,
                                inputFormatters: <TextInputFormatter>[
                                  DateInputFormatter(),
                                ],
                                validator: (val) => val.isEmpty
                                    ? 'Enter an tanggal lahir'
                                    : null,
                                onChanged: (val) {
                                  setState(() => date = val);
                                }),
                            SizedBox(height: 20.0),
                            TextFormField(
                                initialValue: userData.weight,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Berat badan'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(3)
                                ],
                                validator: (val) => val.isEmpty
                                    ? 'Enter an weight badan'
                                    : null,
                                onChanged: (val) {
                                  setState(() => weight = val);
                                }),
                            SizedBox(height: 20.0),
                            TextFormField(
                                initialValue: userData.height,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Tinggi badan'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(3)
                                ],
                                validator: (val) => val.isEmpty
                                    ? 'Enter an height badan'
                                    : null,
                                onChanged: (val) {
                                  setState(() => height = val);
                                }),
                            SizedBox(height: 20.0),
                            RaisedButton(
                                color: Colors.pink[400],
                                child: Text('Update',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                    await UserService(userUid: user.uid)
                                        .updateUserData(
                                      name.isEmpty ? userData.name : name,
                                      phone.isEmpty ? userData.phone : phone,
                                      gender.isEmpty ? userData.gender : gender,
                                      date.isEmpty ? userData.birthDate : date,
                                      weight.isEmpty ? userData.weight : weight,
                                      height.isEmpty ? userData.height : height,
                                    );

                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Please supply a valid datas';
                                      });
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  }
                                }),
                            SizedBox(height: 12.0),
                            Text(error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0))
                          ])))
                ]));
          }
        });
  }
}
