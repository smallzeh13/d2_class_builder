import 'package:flutter/material.dart';
import 'package:d2_class_builder/services/authentication.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Authentication oauth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/img/login_bg.jpg'),
          fit: BoxFit.cover,
        )),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 195, 10, 0),
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 100,
                      fontFamily: 'ArialStd',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  //color: Colors.red,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 240, 0, 0),
                  child: Text(
                    'DESTINY',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 120),
              child: Text('=CLASS BUILDER='),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () async {
                    dynamic token = await Authentication.authorize();
                    Navigator.pushNamed(context, '/landing', arguments: token);
                  },
                  child: Text('Authenticate'),
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
