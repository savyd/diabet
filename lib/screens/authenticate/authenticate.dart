import 'package:diabet/models/user.dart';
import 'package:diabet/screens/authenticate/welcome.dart';
import 'package:diabet/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Welcome();
    } else {
      return Home();
    }
  }
}
