class Statement {
  String created;
  String actnbr;
  String statement_id;
  String type;
  String url;
  bool hidden = true;

  Statement(
    this.created,
    this.actnbr,
    this.statement_id,
    this.type,
    this.url,
  );

  factory Statement.fromJson(dynamic json) {
    return Statement(
        json['CREATED'] as String,
        json['ACCOUNT'] as String,
        json['STATEMENTID'] as String,
        json['TYPE'] as String,
        json['URL'] as String);
  }
}
