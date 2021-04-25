import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VendorAccount
{
  VendorAccount({this.email,this.displayName});
  String email, displayName;
  factory VendorAccount.fromJson(Map<String, dynamic> json) =>
      _$VendorAccountFromJson(json);

  Map<String, dynamic> toJson() => _$VendorAccountToJson(this);
}

VendorAccount _$VendorAccountFromJson(Map<String, dynamic> json) {
  return VendorAccount(
    email: json['email'],
    displayName: json['displayName']
  );
}

Map<String, dynamic> _$VendorAccountToJson(VendorAccount vendorAccount) => <String, dynamic>{
      'email': vendorAccount.email,
      'displayName': vendorAccount.displayName,
    };