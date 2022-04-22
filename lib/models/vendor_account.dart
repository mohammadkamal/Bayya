import 'dart:convert';

class VendorAccount {
  VendorAccount({this.email, this.displayName, this.uid});

  String email, displayName, uid;

  VendorAccount copyWith(String email, String displayName, String uid) {
    return VendorAccount(
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        uid: uid ?? this.uid);
  }

  Map<String, dynamic> toMap() {
    return {'displayName': displayName, 'email': email, 'uid': uid}
      ..removeWhere((key, value) => key == null || value == null);
  }

  factory VendorAccount.fromMap(Map<String, dynamic> map) {
    return VendorAccount(
        displayName: map['displayName'], email: map['email'], uid: map['uid']);
  }

  factory VendorAccount.fromJson(String json) =>
      VendorAccount.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());

  @override
  String toString() {
    return 'VendorAccount(displayName: $displayName, email: $email, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendorAccount &&
        other.displayName == this.displayName &&
        other.email == this.email &&
        other.uid == this.uid;
  }

  @override
  int get hashCode => displayName.hashCode ^ email.hashCode ^ uid.hashCode;
}
