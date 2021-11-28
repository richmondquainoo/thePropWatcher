class ServiceChargeModel {
  int id;
  String serviceCode;
  String serviceName;
  double amount;
  double tax;

  ServiceChargeModel({
    this.id,
    this.serviceCode,
    this.serviceName,
    this.amount,
    this.tax,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'serviceCode': serviceCode,
      'serviceName': serviceName,
      'amount': amount,
      'tax': tax,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'serviceCode': serviceCode,
      'serviceName': serviceName,
      'amount': amount,
      'tax': tax,
    };
  }

  @override
  String toString() {
    return 'ServiceChargeModel{id: $id, serviceCode: $serviceCode, serviceName: $serviceName, amount: $amount, tax: $tax}';
  }
}
