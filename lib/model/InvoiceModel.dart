class InvoiceModel {
  int id;
  String invoiceNo;
  String serviceCode;
  String serviceName;
  String phone;
  String email;
  String name;
  String status;
  String dateCreated;
  String date;
  double amount;
  double tax;
  double totalAmount;
  String description;
  String callbackUrl;
  String returnUrl;
  String merchantAccountNumber;
  String cancellationUrl;
  String clientReference;
  double paymentAmount;
  String checkoutId;
  String checkoutUrl;
  String paymentDate;
  String paymentMode;
  String origin;
  String momo;
  String requestObject;
  String responseObject;

  InvoiceModel({
    this.id,
    this.invoiceNo,
    this.serviceCode,
    this.serviceName,
    this.phone,
    this.email,
    this.name,
    this.status,
    this.dateCreated,
    this.date,
    this.amount,
    this.tax,
    this.totalAmount,
    this.description,
    this.callbackUrl,
    this.returnUrl,
    this.merchantAccountNumber,
    this.cancellationUrl,
    this.clientReference,
    this.paymentAmount,
    this.checkoutId,
    this.checkoutUrl,
    this.paymentDate,
    this.paymentMode,
    this.origin,
    this.momo,
    this.requestObject,
    this.responseObject,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceNo': invoiceNo,
      'serviceCode': serviceCode,
      'serviceName': serviceName,
      'phone': phone,
      'email': email,
      'name': name,
      'status': status,
      'dateCreated': dateCreated,
      'date': date,
      'amount': amount,
      'tax': tax,
      'totalAmount': totalAmount,
      'description': description,
      'callbackUrl': callbackUrl,
      'returnUrl': returnUrl,
      'merchantAccountNumber': merchantAccountNumber,
      'cancellationUrl': cancellationUrl,
      'clientReference': clientReference,
      'paymentAmount': paymentAmount,
      'checkoutId': checkoutId,
      'checkoutUrl': checkoutUrl,
      'paymentDate': paymentDate,
      'paymentMode': paymentMode,
      'origin': origin,
      'momo': momo,
      'requestObject': requestObject,
      'responseObject': responseObject,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'id': id,
      'invoiceNo': invoiceNo,
      'serviceCode': serviceCode,
      'serviceName': serviceName,
      'phone': phone,
      'email': email,
      'name': name,
      'status': status,
      'dateCreated': dateCreated,
      'date': date,
      'amount': amount,
      'tax': tax,
      'totalAmount': totalAmount,
      'description': description,
      'callbackUrl': callbackUrl,
      'returnUrl': returnUrl,
      'merchantAccountNumber': merchantAccountNumber,
      'cancellationUrl': cancellationUrl,
      'clientReference': clientReference,
      'paymentAmount': paymentAmount,
      'checkoutId': checkoutId,
      'checkoutUrl': checkoutUrl,
      'paymentDate': paymentDate,
      'paymentMode': paymentMode,
      'origin': origin,
      'momo': momo,
      'requestObject': requestObject,
      'responseObject': responseObject,
    };
  }

  @override
  String toString() {
    return 'InvoiceModel{id: $id, invoiceNo: $invoiceNo, serviceCode: $serviceCode, serviceName: $serviceName, phone: $phone, email: $email, name: $name, status: $status, dateCreated: $dateCreated, date: $date, amount: $amount, tax: $tax, totalAmount: $totalAmount, description: $description, callbackUrl: $callbackUrl, returnUrl: $returnUrl, merchantAccountNumber: $merchantAccountNumber, cancellationUrl: $cancellationUrl, clientReference: $clientReference, paymentAmount: $paymentAmount, checkoutId: $checkoutId, checkoutUrl: $checkoutUrl, paymentDate: $paymentDate, paymentMode: $paymentMode, origin: $origin, momo: $momo, requestObject: $requestObject, responseObject: $responseObject}';
  }
}
