class AddressDetail {
  String address;
  String primary;

  AddressDetail(this.address, this.primary);

  factory AddressDetail.fromJson(dynamic json) {
    return AddressDetail(json["address"], json['primary']);
  }
  dynamic getProp(String key) => <String, dynamic>{
        'address': address,
      }[key];
}

class EmailDetail {
  String email;
  String pref_seq;

  EmailDetail(this.email, this.pref_seq);

  factory EmailDetail.fromJson(dynamic json) {
    return EmailDetail(json["email"], json['pref_seq']);
  }
  dynamic getProp(String key) => <String, dynamic>{
        'email': email,
      }[key];
}

class PhoneDetail {
  String phone;
  String pref_seq;

  PhoneDetail(this.phone, this.pref_seq);

  factory PhoneDetail.fromJson(dynamic json) {
    return PhoneDetail(json["phone"], json['pref_seq']);
  }

  dynamic getProp(String key) => <String, dynamic>{
        'phone': phone,
      }[key];
}

class AccDetails {
  String full_name = "";
  List<AddressDetail> addresses = [];
  List<EmailDetail> emails = [];
  List<PhoneDetail> phones = [];

  AccDetails(this.full_name, this.addresses, this.emails, this.phones);
  AccDetails.empty() {
    // var json = {
    //   "address":
    //       "R Cel Ferreira 1152 Q 02 Casa 15 Condominio Ilha do Anjo Cabo Frio RJ 28915370 Brazil",
    //   "primary": "Y"
    // };
    // addresses = [AddressDetail.fromJson(json)];
    // var json2 = {"email": "claudioeduardoferro@me.com", "pref_seq": "10"};

    // emails = [EmailDetail.fromJson(json2)];
    // var json3 = {"phone": "+55 22997642596 (HOM)", "pref_seq": "1"};
    // phones = [PhoneDetail.fromJson(json3)];
  }

  factory AccDetails.fromJson(dynamic json) {
    var full_name = json["full_name"];
    List<AddressDetail> addresses = [
      for (var i in json['addresses']) ...[AddressDetail.fromJson(i)]
    ];
    List<EmailDetail> emails = [
      for (var i in json['emails']) ...[EmailDetail.fromJson(i)]
    ];
    List<PhoneDetail> phones = [
      for (var i in json['phones']) ...[PhoneDetail.fromJson(i)]
    ];
    return AccDetails(full_name, addresses, emails, phones);
  }
}
