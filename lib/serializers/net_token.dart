import 'package:json_annotation/json_annotation.dart';

part 'net_token.g.dart';

@JsonSerializable()
class NetToken {
  String authToken;
  String accessToken;
  String epriresIn;
  String refreshToken;
  String refreshExpiresIn;
  String membershipId;

  NetToken({this.accessToken, this.authToken});
  factory NetToken.fromJson(Map<String, dynamic> json) =>
      _$NetTokenFromJson(json);
  Map<String, dynamic> toJson() => _$NetTokenToJson(this);
}
