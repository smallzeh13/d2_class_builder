// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetToken _$NetTokenFromJson(Map<String, dynamic> json) {
  return NetToken(
    accessToken: json['accessToken'] as String,
    authToken: json['authToken'] as String,
  )
    ..epriresIn = json['epriresIn'] as String
    ..refreshToken = json['refreshToken'] as String
    ..refreshExpiresIn = json['refreshExpiresIn'] as String
    ..membershipId = json['membershipId'] as String;
}

Map<String, dynamic> _$NetTokenToJson(NetToken instance) => <String, dynamic>{
      'authToken': instance.authToken,
      'accessToken': instance.accessToken,
      'epriresIn': instance.epriresIn,
      'refreshToken': instance.refreshToken,
      'refreshExpiresIn': instance.refreshExpiresIn,
      'membershipId': instance.membershipId,
    };
