class ServiceChargeModel {
  int id;
  String serviceCode;
  String serviceName;
  double amount;
  double tax;
  double levy;

  ServiceChargeModel(
      {this.id,
      this.serviceCode,
      this.serviceName,
      this.amount,
      this.tax,
      this.levy});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'serviceCode': serviceCode,
      'serviceName': serviceName,
      'amount': amount,
      'tax': tax,
      'levy': levy,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'serviceCode': serviceCode,
      'serviceName': serviceName,
      'amount': amount,
      'tax': tax,
      'levy': levy,
    };
  }

  @override
  String toString() {
    return 'ServiceChargeModel{id: $id, serviceCode: $serviceCode, serviceName: $serviceName, amount: $amount, tax: $tax, levy: $levy}';
  }
}
