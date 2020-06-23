import 'package:diabet/models/interface.dart';
import 'package:diabet/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diabet/screens/dashboard/dashboard_menu.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff392850),
        body: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 80, bottom: 40),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Dashboard",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(height: 4),
                        Text(Interface.appName,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Color(0xffa29aac),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    IconButton(
                        alignment: Alignment.topCenter,
                        color: Colors.white,
                        icon: FaIcon(FontAwesomeIcons.timesCircle, size: 30),
                        onPressed: () => _auth.signOut())
                  ])),
          DashboardMenu()
        ]));
  }
}
