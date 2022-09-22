class VerifyRateableRequestModel {
  String valuation_number;
  String gdCode;

  VerifyRateableRequestModel({
    this.valuation_number,
    this.gdCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'valuation_number': valuation_number,
      'gdCode': gdCode,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'valuation_number': valuation_number,
      'gdCode': gdCode,
    };
  }

  @override
  String toString() {
    return 'VerifyRateableRequestModel{valuation_number: $valuation_number, gdCode: $gdCode}';
  }
}
