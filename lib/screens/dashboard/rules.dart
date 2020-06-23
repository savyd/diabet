import 'package:diabet/models/interface.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
