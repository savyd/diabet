import 'dart:convert';

import 'package:diabet/models/interface.dart';
import 'package:diabet/models/user.dart';
import 'package:diabet/services/record.dart';
import 'package:diabet/shared/constants.dart';
import 'package:diabet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecordAddPage extends StatefulWidget {
  @override
  _RecordAddPageState createState() => _RecordAddPageState();
}

class _RecordAddPageState extends State<RecordAddPage> {
  final RecordService _recordService = RecordService();

  final _formKey = GlobalKey<FormState>();

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

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Peringatan'),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[Text(message)])),
              actions: <Widget>[
                FlatButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  String error = '';
  bool loading = false;

  // text field state
  String type = '';
  String date = '';
  String time = '';
  String sugarValue = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (loading) return Loading();

    return Scaffold(
        backgroundColor: Color(Interface.background),
        appBar: AppBar(
            backgroundColor: Color(Interface.background),
            title: Text("Add Record",
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/rules.json'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Loading();

                    var data = json.decode(snapshot.data);

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('catatan:',
                              textAlign: TextAlign.left, style: textStyleRow),
                          SizedBox(height: Interface.boxSizeTiny),
                          Text(data['catatan'][0], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeTiny),
                          Text(data['catatan'][1], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeTiny),
                          Text(data['catatan'][2], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeTiny),
                          Text(data['catatan'][3], style: textStyleRow),
                          SizedBox(height: Interface.boxSizeTiny),
                        ]);
                  })),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Type cek darah'),
                        items: <String>['Sewaktu', 'PP', 'GDP']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (val) {
                          setState(() => type = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Tanggal cek darah'),
                        keyboardType: TextInputType.datetime,
                        inputFormatters: <TextInputFormatter>[
                          DateInputFormatter()
                        ],
                        validator: (val) =>
                            val.isEmpty ? 'Enter an tanggal cek' : null,
                        onChanged: (val) {
                          setState(() => date = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Waktu cek darah'),
                        keyboardType: TextInputType.datetime,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(5)
                        ],
                        validator: (val) =>
                            val.isEmpty ? 'Enter a waktu cek darah' : null,
                        onChanged: (val) {
                          setState(() => time = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Kadar gula darah'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(3)
                        ],
                        validator: (val) =>
                            val.isEmpty ? 'Enter an kadar gula darah' : null,
                        onChanged: (val) {
                          setState(() => sugarValue = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Add Record',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _recordService.createRecord(
                                type: type,
                                userUid: user.uid,
                                date: date,
                                time: time,
                                sugarLevel: sugarValue);

                            if (result == null) {
                              return _showMyDialog(
                                  'Harap periksa koneksi internet anda');
                            } else {
                              loading = false;
                              int sugar = int.parse(sugarValue);
                              String message =
                                  'Harap cek tips dari kami, karna kadar gula anda sedang tinggi.';

                              if (type == 'PP' && sugar > 140) {
                                return _showMyDialog(message);
                              }
                              if (type == 'GDP' && sugar > 100) {
                                return _showMyDialog(message);
                              }
                              if (type == 'Sewaktu' && sugar > 130) {
                                return _showMyDialog(message);
                              }
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                          color: Colors.red, fontSize: Interface.fontSizeTitle),
                    )
                  ])))
        ]));
  }
}
