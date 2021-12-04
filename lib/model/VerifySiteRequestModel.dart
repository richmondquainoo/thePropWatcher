import 'package:elandguard/model/CoordinateModel.dart';

class VerifySiteRequestModel {
  String applicant_name;
  String ref_number;
  List<CoordinateModel> wkt;

  VerifySiteRequestModel({
    this.applicant_name,
    this.ref_number,
    this.wkt,
  });

  Map<String, dynamic> toMap() {
    return {
      'applicant_name': applicant_name,
      'ref_number': ref_number,
      'wkt': wkt,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'applicant_name': applicant_name,
      'ref_number': ref_number,
      'wkt': wkt,
    };
  }

  @override
  String toString() {
    return 'VerifySiteRequestModel{applicant_name: $applicant_name, ref_number: $ref_number, wkt: $wkt}';
  }
}
