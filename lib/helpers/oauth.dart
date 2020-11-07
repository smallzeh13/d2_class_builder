import 'dart:convert';

import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uni_links/uni_links.dart';

const String OAUTH_CLIENT_ID = '34470';
//const String OAUTH_AUTH_URL = 'https://www.bungie.net/';
const String OAUTH_REDIRECT_URI = 'com.kismet.d2classbuilder://oauth';

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
    var browser = BungieAuthBrowser();
    openOAuth(browser, OAUTH_CLIENT_ID, true);

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
    linkStreamSubscription.cancel();
    return completer.future;
  }

  static Future<Response> getToken(authCode) async {
    String url = 'https://www.bungie.net/Platform/App/OAuth/Token/';
    try {
      return post(url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body:
              'client_id=$OAUTH_CLIENT_ID&grant_type=authorization_code&code=$authCode');
    } catch (error) {
      return error;
    }
  }

  static Future<String> refreshToken(token) {}
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
