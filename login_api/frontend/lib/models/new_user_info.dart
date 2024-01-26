import 'dart:convert';

class NewUserInfo {
  String? name;
  String? email;
  String? cust_key;
  String? tax_id;
  bool is_empty;

  NewUserInfo(this.name, this.email, this.cust_key, this.tax_id,
      {this.is_empty = false});

  NewUserInfo.empty({this.is_empty = true}) {}

  factory NewUserInfo.fromJson(String sjson) {
    dynamic json = jsonDecode(sjson);
    return NewUserInfo(json['name'] as String, json['email'] as String,
        json['cust_key'] as String, json['tax_id'] as String);
  }
}
