import 'package:diabet/models/interface.dart';
import 'package:diabet/screens/dashboard/about.dart';
import 'package:diabet/screens/dashboard/tips.dart';
import 'package:diabet/screens/dashboard/info.dart';
import 'package:diabet/screens/dashboard/profile.dart';
import 'package:diabet/screens/dashboard/record.dart';
import 'package:diabet/screens/dashboard/rules.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardMenu extends StatelessWidget {
  final Items records = new Items(
    title: "Records",
    event: "catat gula darah",
    img: "assets/calendar.png",
    widget: RecordPage(),
  );
  final Items tips = new Items(
    title: "Tips",
    event: "kesehatan",
    img: "assets/food.png",
    widget: TipsPage(),
  );
  final Items about = new Items(
    title: "About",
    event: "seputar applikasi",
    img: "assets/map.png",
    widget: AboutPage(),
  );
  final Items profile = new Items(
    title: "Profile",
    event: "profil pengguna",
    img: "assets/festival.png",
    widget: Profile(),
  );
  final Items info = new Items(
    title: "Info Penting",
    event: "tentang diabets",
    img: "assets/todo.png",
    widget: InfoPage(),
  );
  final Items usage = new Items(
    title: "How To",
    event: "cara pakai appliaksi",
    img: "assets/setting.png",
    widget: RulePage(),
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [records, profile, tips, info, about, usage];
    final color = Interface.cardColor;
    return Flexible(
        child: GridView.count(
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 16, right: 16),
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            children: myList.map((data) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => data.widget));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(color),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(data.img, width: 42),
                            SizedBox(height: 14),
                            Text(data.title,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: Interface.fontSizeTitle,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(height: 14),
                            Text(data.event,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: Interface.fontSizeSmall,
                                        fontWeight: FontWeight.w600))),
                          ])));
            }).toList()));
  }
}

class Items {
  String title;
  String event;
  String img;
  Widget widget;

  Items({this.title, this.event, this.img, this.widget});
}
