import 'dart:async';

import 'package:uni_links/uni_links.dart';
import 'package:bungie_api/helpers/bungie_net_token.dart';
import 'package:bungie_api/helpers/oauth.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

const String OAUTH_DOMAIN = 'www.bungie.net/en/OAuth/Authorize';
const String OAUTH_CLIENT_ID = '34470';
const String OAUTH_REDIRECT_URI = 'com.kismet.d2classbuilder://oauth';
const String OAUTH_ISSUER = 'https://$OAUTH_DOMAIN';

final FlutterAppAuth appAuth = FlutterAppAuth();

class Authentication {
  StreamSubscription<String> linkStreamSubscription;
  Future<void> authorize() async {
    var browser = BungieAuthBrowser();
    OAuth.openOAuth(browser, OAUTH_CLIENT_ID, 'en', true);

    Stream<String> _stream = getLinksStream();
    Completer<String> completer = Completer();

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
        String errorDescription = uri.queryParameters["error_description"];
        try {
          throw OAuthException(errorType, errorDescription);
        } on OAuthException catch (e, stack) {
          completer.completeError(e, stack);
        }
      }
      print(completer.future);
    });
  }
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
