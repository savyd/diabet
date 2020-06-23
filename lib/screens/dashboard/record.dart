import 'package:diabet/models/interface.dart';
import 'package:diabet/models/record.dart';
import 'package:diabet/models/user.dart';
import 'package:diabet/services/record.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Record>>.value(
        value: RecordService().recordLists(user.uid),
        child: Scaffold(
          backgroundColor: Color(0xff392850),
          appBar: AppBar(
              backgroundColor: Color(Interface.background),
              title: Text("Record Kadar Gula",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: Interface.fontSizeTitle,
                          fontWeight: FontWeight.bold)))),
          body: ListView(
            children: <Widget>[],
          ),
        ));
  }
}
