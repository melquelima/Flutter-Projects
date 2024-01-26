import 'package:amplify_flutter/amplify_flutter.dart';

class User {
  String userName = "";

  User(this.userName);

  User.factory() {
    userName = "";
  }

  factory User.fromJson(dynamic json) {
    return User(json['username'] as String);
  }
}

class Auth {
  int? id;
  String token = "";
  User user = User.factory();

  Auth(this.token, this.user);
  Auth.empty() {}

  factory Auth.fromJson(dynamic json) {
    return Auth(json['token'] as String, User.fromJson(json['user']));
  }
}

class AuthAmp {
  AuthUser user;
  String email;
  String tax_id;
  String cust_key;

  AuthAmp(this.user, this.email, this.tax_id, this.cust_key);

  factory AuthAmp.fromAmplify(
      AuthUser authUser, List<AuthUserAttribute> attributes) {
    var email = attributes
        .where((e) => e.userAttributeKey.key == "email")
        .toList()[0]
        .value;
    var tax_id = attributes
        .where((e) => e.userAttributeKey.key == "custom:taxid")
        .toList()[0]
        .value;
    var cust_key = attributes
        .where((e) => e.userAttributeKey.key == "custom:custkey")
        .toList()[0]
        .value;
    return AuthAmp(authUser, email, tax_id, cust_key);
  }
}
