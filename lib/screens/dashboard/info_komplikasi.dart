import 'dart:convert';

import 'package:diabet/models/interface.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoKomplikasi extends StatelessWidget {
  final textStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: Interface.fontSizeNormal,
          fontWeight: FontWeight.w600));

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(Interface.cardColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/about.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              } else {
                var data = json.decode(snapshot.data);

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['komplikasi']['hipoglikemia'],
                          style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['komplikasi']['gejala'], style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text('Pencegahan:',
                          textAlign: TextAlign.left, style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['komplikasi']['pencegahan'][0],
                          style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['komplikasi']['pencegahan'][2],
                          style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['komplikasi']['pencegahan'][3],
                          style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['komplikasi']['pencegahan'][4],
                          style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                    ]);
              }
            }));
  }
}
