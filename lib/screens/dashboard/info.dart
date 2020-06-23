import 'package:diabet/models/interface.dart';
import 'package:diabet/screens/dashboard/info_definisi.dart';
import 'package:diabet/screens/dashboard/info_gejala.dart';
import 'package:diabet/screens/dashboard/info_komplikasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);

  static List<Widget> _widgetOptions = <Widget>[
    InfoDefinisi(),
    InfoGejala(),
    InfoKomplikasi()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(Interface.background),
        appBar: AppBar(
          backgroundColor: Color(Interface.background),
          title: Text("Tentang Diabetes Militus 2",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Interface.fontSizeTitle,
                      fontWeight: FontWeight.bold))),
        ),
        body: ListView(children: <Widget>[
          _widgetOptions.elementAt(_selectedIndex)
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.book), title: Text('Definisi')),
            BottomNavigationBarItem(
                icon: Icon(Icons.report), title: Text('Gejala')),
            BottomNavigationBarItem(
                icon: Icon(Icons.report_problem), title: Text('Komplikasi')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}
