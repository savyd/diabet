import 'package:diabet/models/interface.dart';
import 'package:diabet/services/auth.dart';
import 'package:diabet/shared/constants.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String repeatPassword = '';
  String fullname = '';
  String phoneNumber = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(Interface.background),
            appBar: AppBar(
                backgroundColor: Color(Interface.background),
                actions: <Widget>[
                  IconButton(
                    color: Colors.white,
                    alignment: Alignment.topCenter,
                    icon: FaIcon(
                      FontAwesomeIcons.userCircle,
                      size: 30,
                    ),
                    onPressed: () => widget.toggleView(),
                  )
                ],
                title: Text("Registrasi",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: Interface.fontSizeTitle,
                            fontWeight: FontWeight.bold)))),
            body: ListView(children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) return 'Enter a password';
                              if (val.length < 6)
                                return 'Enter a password 6+ chars long';

                              return null;
                            },
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Repeat password'),
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) return 'Enter a password';
                              if (val.length < 6)
                                return 'Enter a password 6+ chars long';
                              if (val != password) return 'Password not valid';

                              return null;
                            },
                            onChanged: (val) {
                              setState(() => repeatPassword = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Nama Lengkap'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an nama lengkap' : null,
                            onChanged: (val) {
                              setState(() => fullname = val);
                            }),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Jenis kelamin'),
                            items: <String>['Laki-laki', 'Perempuan']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (val) {
                              setState(() => gender = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Nomor telpon'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an nomor telpon' : null,
                            onChanged: (val) {
                              setState(() => phoneNumber = val);
                            }),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                        fullname: fullname,
                                        gender: gender,
                                        phoneNumber: phoneNumber);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Interface.fontSizeTitle),
                        )
                      ])))
            ]));
  }
}
