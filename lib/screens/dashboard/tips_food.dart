import 'dart:convert';

import 'package:diabet/models/interface.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TipsFood extends StatelessWidget {
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

                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowHeight: 120.0,
                      columns: <DataColumn>[
                        DataColumn(
                            label:
                                Text("Bahan Makanan", style: textStyleColumn)),
                        DataColumn(
                            label: Text("Dianjurkan", style: textStyleColumn)),
                        DataColumn(
                            label: Text("Dibatasi", style: textStyleColumn)),
                        DataColumn(
                            label: Text("Dihindari", style: textStyleColumn)),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][0]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][0]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][0]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][0]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][1]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][1]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][1]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][1]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][2]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][2]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][2]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][2]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][3]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][3]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][3]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][3]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][4]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][4]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][4]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][4]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][5]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][5]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][5]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][5]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data['makanan'][6]['bahan_makanan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][6]['dianjurkan'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][6]['dibatasi'],
                                style: textStyleRow)),
                            DataCell(Text(data['makanan'][6]['dihindari'],
                                style: textStyleRow)),
                          ],
                        ),
                      ],
                    ));
              }
            }));
  }
}
