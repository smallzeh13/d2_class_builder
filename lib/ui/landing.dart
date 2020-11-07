import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String data = '';
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(data),
      ),
    );
  }
}
