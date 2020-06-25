import 'dart:convert';

import 'package:diabet/models/interface.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RulePage extends StatelessWidget {
  final textStyleColumn = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: Interface.fontSizeNormal,
          fontWeight: FontWeight.w600));

  final textStyleRow = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: Interface.fontSizeSmall,
          fontWeight: FontWeight.w600));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(Interface.background),
        appBar: AppBar(
          backgroundColor: Color(Interface.background),
          title: Text("Cara Penggunaan Applikasi",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Interface.fontSizeTitle,
                      fontWeight: FontWeight.bold))),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(Interface.cardColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/rules.json'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Loading();

                  var data = json.decode(snapshot.data);

                  return ListView(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: Interface.boxSizeNormal),
                          Text('Jenis Test Darah:',
                              textAlign: TextAlign.left, style: textStyleRow),
                          SizedBox(height: Interface.boxSizeNormal)
                        ]),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(columns: <DataColumn>[
                          DataColumn(
                              label: Text("Jenis", style: textStyleColumn)),
                          DataColumn(
                              label:
                                  Text("Nilai Normal", style: textStyleColumn)),
                        ], rows: <DataRow>[
                          DataRow(cells: <DataCell>[
                            DataCell(Text(data['kategori_cek_gula'][0]['jenis'],
                                style: textStyleRow)),
                            DataCell(Text(
                                data['kategori_cek_gula'][0]['nilai_normal'],
                                style: textStyleRow)),
                          ]),
                          DataRow(cells: <DataCell>[
                            DataCell(Text(data['kategori_cek_gula'][1]['jenis'],
                                style: textStyleRow)),
                            DataCell(Text(
                                data['kategori_cek_gula'][1]['nilai_normal'],
                                style: textStyleRow)),
                          ]),
                          DataRow(cells: <DataCell>[
                            DataCell(Text(data['kategori_cek_gula'][2]['jenis'],
                                style: textStyleRow)),
                            DataCell(Text(
                                data['kategori_cek_gula'][2]['nilai_normal'],
                                style: textStyleRow)),
                          ])
                        ])),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Text('catatan:',
                              textAlign: TextAlign.left, style: textStyleRow),
                          SizedBox(height: Interface.boxSizeNormal),
                          Text(data['catatan'][0], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeNormal),
                          Text(data['catatan'][1], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeNormal),
                          Text(data['catatan'][2], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeNormal),
                          Text(data['catatan'][3], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeNormal),
                        ])
                  ]);
                })));
  }
}
