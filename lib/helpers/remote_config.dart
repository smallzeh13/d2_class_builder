import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class D2RemoteConfig {
  String oAuthClientId;
  String oAuthRedirectUrl;
  String oAuthClientSecret;

  D2RemoteConfig();

  Future<void> init() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 1));
    await remoteConfig.activateFetched();

    oAuthClientId = remoteConfig.getString('OAuthClientId');
    oAuthRedirectUrl = remoteConfig.getString('OAuthRedirctionUrl');
    oAuthClientSecret = remoteConfig.getString('APIClientSecret');
  }
}
