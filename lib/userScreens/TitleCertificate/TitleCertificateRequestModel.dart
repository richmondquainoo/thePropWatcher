class TitleCertificateRequestModel {
  String certificate_number;

  TitleCertificateRequestModel({
    this.certificate_number,
  });

  Map<String, dynamic> toMap() {
    return {
      'certificate_number': certificate_number,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'certificate_number': certificate_number,
    };
  }

  @override
  String toString() {
    return 'TitleCertificateRequestModel{certificate_number: $certificate_number}';
  }
}
