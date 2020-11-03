import 'package:flutter/material.dart';
import 'package:d2_class_builder/ui/login.dart';
import 'package:d2_class_builder/ui/landing.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Futurist'),
      routes: {
        '/': (context) => Login(),
        '/landing': (context) => Landing(),
      },
    ));
