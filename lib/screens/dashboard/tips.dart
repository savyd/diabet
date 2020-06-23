import 'package:diabet/models/interface.dart';
import 'package:diabet/screens/dashboard/tips_food.dart';
import 'package:diabet/screens/dashboard/tips_sport.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TipsPage extends StatefulWidget {
  TipsPage({Key key}) : super(key: key);

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);

  static List<Widget> _widgetOptions = <Widget>[
    TipsFood(),
    TipsSport()
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
          title: Text("Tips Menjaga Kesehatan",
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
                icon: Icon(Icons.book), title: Text('Makanan')),
            BottomNavigationBarItem(
                icon: Icon(Icons.report), title: Text('Olahraga')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}
