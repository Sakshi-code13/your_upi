class ScanData {
  final String payeeName;
  final String upiId;
  final String merchantCode;
  final String transactionId;
  final String transactionRefId;
  final String transactionNote;
  final String amount;
  final DateTime scanDate;

  ScanData({
    required this.payeeName,
    required this.upiId,
    this.merchantCode = '',
    this.transactionId = '',
    this.transactionRefId = '',
    this.transactionNote = '',
    this.amount = '',
    required this.scanDate,
  });

  factory ScanData.fromUpiString(String upiString) {
    // Parse UPI string like: upi://pay?pa=<UPIID>&pn=<Name>&mc=<MerchantCode>&tid=<TransactionId>&tr=<TransactionRefId>&tn=<TransactionNote>&am=<Amount>
    final uri = Uri.parse(upiString);
    final queryParams = uri.queryParameters;

    return ScanData(
      payeeName: queryParams['pn'] ?? '',
      upiId: queryParams['pa'] ?? '',
      merchantCode: queryParams['mc'] ?? '',
      transactionId: queryParams['tid'] ?? '',
      transactionRefId: queryParams['tr'] ?? '',
      transactionNote: queryParams['tn'] ?? '',
      amount: queryParams['am'] ?? '',
      scanDate: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payeeName': payeeName,
      'upiId': upiId,
      'merchantCode': merchantCode,
      'transactionId': transactionId,
      'transactionRefId': transactionRefId,
      'transactionNote': transactionNote,
      'amount': amount,
      'scanDate': scanDate.toIso8601String(),
    };
  }

  factory ScanData.fromMap(Map<String, dynamic> map) {
    return ScanData(
      payeeName: map['payeeName'] ?? '',
      upiId: map['upiId'] ?? '',
      merchantCode: map['merchantCode'] ?? '',
      transactionId: map['transactionId'] ?? '',
      transactionRefId: map['transactionRefId'] ?? '',
      transactionNote: map['transactionNote'] ?? '',
      amount: map['amount'] ?? '',
      scanDate: DateTime.parse(map['scanDate']),
    );
  }
}
