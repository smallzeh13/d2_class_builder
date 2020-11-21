import 'package:d2_class_builder/helpers/remote_config.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uni_links/uni_links.dart';

class OAuth {
  static void openOAuth(OAuthBrowser browser, String clientId,
      [bool reauth = false]) {
    String url =
        'https://www.bungie.net/en/OAuth/Authorize?client_id=$clientId&response_type=code';
    if (reauth) {
      url = '$url&reauth=true';
    }
    browser.open(url);
  }

  static Future<String> getAuthCode() async {
    var config = new D2RemoteConfig();
    await config.init();
    var browser = BungieAuthBrowser();
    openOAuth(browser, config.oAuthClientId, true);

    StreamSubscription<String> linkStreamSubscription;
    Stream<String> _stream = getLinksStream();
    Completer<String> completer = Completer();
    //cancel stream if already active
    linkStreamSubscription?.cancel();

    linkStreamSubscription = _stream.listen((link) {
      Uri uri = Uri.parse(link);

      if (uri.queryParameters.containsKey("code") ||
          uri.queryParameters.containsKey("error")) {
        closeWebView();
        linkStreamSubscription.cancel();
      }
      if (uri.queryParameters.containsKey("code")) {
        String code = uri.queryParameters["code"];
        completer.complete(code);
      } else {
        String errorType = uri.queryParameters["error"];
        //String errorDescription = uri.queryParameters["error_description"];
        completer.complete(errorType);
      }
    });
    return completer.future;
  }

  static Future<String> getToken(authCode, [bool isrefresh]) async {
    var config = new D2RemoteConfig();
    await config.init();
    var client = Client();
    String url = 'https://www.bungie.net/Platform/App/OAuth/Token/';
    String body;
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body:
            'client_id=${config.oAuthClientId}&client_secret=${config.oAuthClientSecret}&grant_type=authorization_code&code=$authCode');
    if (response.statusCode == 200) {
      body = response.body;
    } else {
      throw OAuthException(response.statusCode, response.body);
    }
    return body;
  }

  // i dont like how i duplicated code here, will need a rework but it is easir to read in parent class
  static Future<String> refreshToken(refreshToken) async {
    var config = new D2RemoteConfig();
    await config.init();
    var client = Client();
    String url = 'https://www.bungie.net/Platform/App/OAuth/Token/';
    String body;
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body:
            'client_id=${config.oAuthClientId}&client_secret=${config.oAuthClientSecret}&&refresh_token=$refreshToken&grant_type=refresh_token');
    if (response.statusCode == 200) {
      body = response.body;
    } else {
      throw OAuthException(response.statusCode, response.body);
    }
    return body;
  }
}

abstract class OAuthBrowser {
  void open(String url);
}

class BungieAuthBrowser implements OAuthBrowser {
  @override
  dynamic open(String url) async {
    if (Platform.isIOS) {
      await launch(url,
          forceSafariVC: true, statusBarBrightness: Brightness.light);
    } else {
      await launch(url, forceSafariVC: true);
    }
  }
}

class OAuthException implements Exception {
  OAuthException(this.error, [this.errorDescription]);

  final dynamic error;
  final String errorDescription;
  String toString() {
    return '$error : $errorDescription';
  }
}
