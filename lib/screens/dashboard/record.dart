import 'package:diabet/models/interface.dart';
import 'package:diabet/models/record.dart';
import 'package:diabet/models/user.dart';
import 'package:diabet/screens/dashboard/record_add.dart';
import 'package:diabet/services/record.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
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

  _buildList(BuildContext context, List<Record> records) {
    return records.map((data) {
      return DataRow(cells: [
        DataCell(Text(data.date, style: textStyleRow)),
        DataCell(Text(data.time, style: textStyleRow)),
        DataCell(Text(data.sugarLevel, style: textStyleRow)),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Color(0xff392850),
      appBar: AppBar(
          backgroundColor: Color(Interface.background),
          title: Text("Record Kadar Gula",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: Interface.fontSizeTitle,
                      fontWeight: FontWeight.bold))),
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              alignment: Alignment.topCenter,
              icon: FaIcon(
                FontAwesomeIcons.plusCircle,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecordAddPage()));
              },
            )
          ]),
      body: ListView(
        children: <Widget>[
          StreamBuilder<List<Record>>(
            stream: RecordService().recordLists(user.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading();

              return DataTable(columns: [
                DataColumn(label: Text('Tanggal', style: textStyleColumn)),
                DataColumn(label: Text('Jam', style: textStyleColumn)),
                DataColumn(label: Text('Kadar gula', style: textStyleColumn)),
              ], rows: _buildList(context, snapshot.data));
            },
          )
        ],
      ),
    );
  }
}
