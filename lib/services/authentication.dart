import 'dart:async';

import 'package:uni_links/uni_links.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:d2_class_builder/helpers/oauth.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Authentication {
  Future<Response> authorize() async {
    String authCode = await OAuth.getAuthCode();
    dynamic token = await OAuth.getToken(authCode);

    return token;
  }
}
