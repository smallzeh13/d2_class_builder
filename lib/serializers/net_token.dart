import 'package:json_annotation/json_annotation.dart';

part 'net_token.g.dart';

@JsonSerializable()
class NetToken {
  NetToken(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.membershipId,
      this.refreshToken,
      this.refreshExpiresIn});
  factory NetToken.fromJson(Map<String, dynamic> json) =>
      _$NetTokenFromJson(json);
  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'token_type')
  String tokenType;

  @JsonKey(name: 'expires_in')
  int expiresIn;

  @JsonKey(name: 'membership_id')
  String membershipId;

  @JsonKey(name: 'refresh_token')
  String refreshToken;

  @JsonKey(name: 'refresh_expires_in')
  int refreshExpiresIn;

  Map<String, dynamic> toJson() => _$NetTokenToJson(this);
}
