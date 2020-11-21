// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetToken _$NetTokenFromJson(Map<String, dynamic> json) {
  return NetToken(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: json['expires_in'] as int,
    membershipId: json['membership_id'] as String,
    refreshToken: json['refresh_token'] as String,
    refreshExpiresIn: json['refresh_expires_in'] as int,
  );
}

Map<String, dynamic> _$NetTokenToJson(NetToken instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'membership_id': instance.membershipId,
      'refresh_token': instance.refreshToken,
      'refresh_expires_in': instance.refreshExpiresIn,
    };
