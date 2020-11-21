import 'dart:async';
import 'dart:convert';
import 'package:d2_class_builder/helpers/oauth.dart';
import 'package:d2_class_builder/serializers/net_token.dart';

class Authentication {
  static Future<String> authorize() async {
    String authCode = await OAuth.getAuthCode();
    String token = await OAuth.getToken(authCode);
    Map<String, dynamic> auth = jsonDecode(token);
    var oauthTokenResponse = NetToken.fromJson(auth);

    return oauthTokenResponse.refreshToken;
  }
}
