import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:d2_class_builder/helpers/oauth.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Authentication {
  static Future<String> authorize() async {
    String authCode = await OAuth.getAuthCode();
    dynamic token = await OAuth.getToken(authCode);
    Map<String, dynamic> auth = jsonDecode(token);
    print(auth['access_token']);
    return authCode;
  }
}
