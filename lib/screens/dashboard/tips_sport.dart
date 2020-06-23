import 'dart:convert';

import 'package:diabet/models/interface.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TipsSport extends StatelessWidget {
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
                DefaultAssetBundle.of(context).loadString('assets/tips.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              } else {
                var data = json.decode(snapshot.data);

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: Interface.boxSizeNormal),
                      Text(data['olahraga']['intro'], style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text('Olahraga yg di anjurkan:', style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['kegiatan'][0], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['kegiatan'][1], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['kegiatan'][2], style: textStyle),
                      SizedBox(height: Interface.boxSizeNormal),
                      Text('Catatan:', style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['catatan'][0], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['catatan'][1], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['catatan'][2], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['catatan'][3], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                      Text(data['olahraga']['catatan'][4], style: textStyle),
                      SizedBox(height: Interface.boxSizeSmall),
                    ]);
              }
            }));
  }
}
