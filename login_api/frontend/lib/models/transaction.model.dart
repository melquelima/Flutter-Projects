import 'dart:ffi';

class Transaction {
  num TRANAMT;
  String TRANDESC;
  String? TRANDESCS;
  num CURRBAL;
  String DRCRFLAG;
  DateTime TRANDATE;

  Transaction(this.TRANAMT, this.TRANDESC, this.TRANDESCS, this.CURRBAL,
      this.DRCRFLAG, this.TRANDATE);

  factory Transaction.fromJson(dynamic json) {
    return Transaction(json['TRANAMT'], json['TRANDESC'], json['TRANDESCS'],
        json['CURRBAL'], json['DRCRFLAG'], json['TRANDATE']);
  }
}
