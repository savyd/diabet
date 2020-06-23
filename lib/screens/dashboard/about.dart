import 'dart:convert';

import 'package:diabet/models/interface.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff392850),
        appBar: AppBar(
            backgroundColor: Color(Interface.background),
            title: Text("Tentang Applikasi",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: Interface.fontSizeTitle,
                        fontWeight: FontWeight.bold)))),
        body: ListView(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(Interface.cardColor),
                  borderRadius: BorderRadius.circular(10)),
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/about.json'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading();
                    } else {
                      var data = json.decode(snapshot.data);

                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Image.asset('assets/todo.png', width: 100),
                            SizedBox(height: 20),
                            Text(data['about'],
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: Interface.fontSizeNormal,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(height: 20),
                          ]);
                    }
                  }))
        ]));
  }
}
