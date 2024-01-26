class Account {
  String product;
  String actnbr;
  num availbal;
  String shortname;
  String officer;
  bool hidden = true;

  Account(
    this.product,
    this.actnbr,
    this.availbal,
    this.shortname,
    this.officer,
  );

  factory Account.fromJson(dynamic json) {
    return Account(
        json['PRODUCT'] as String,
        json['ACTNBR'] as String,
        double.parse(json['AVAILBAL']),
        json['SHORTNAME'] as String,
        json['OFFICER'] as String);
  }
}
