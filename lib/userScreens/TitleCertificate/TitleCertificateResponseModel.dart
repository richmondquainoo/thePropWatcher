class TitleCertificateResponseModel {
  String gid;
  String nature_of_instument;
  String date_of_registration;
  String volume;
  String date_of_issued_cert_no;
  String type_of_certificate;
  String registered_number;
  String cc_number;
  String certicate_number;
  String applicant_name;
  String grantor_name;
  String job_number;
  String type_instrument;
  String date_of_instument;
  String consideration;
  String purpose;
  String date_commencement;
  String term;
  String remarks;
  String plotted_by_reg;
  String checked_by;
  String plott_date_reg;
  String type_of_registration;
  String fid_id_fk;
  String plan_number;
  String encumbrance;
  String status;
  String reference_number;
  String land_size;

  TitleCertificateResponseModel({
    this.gid,
    this.nature_of_instument,
    this.date_of_registration,
    this.volume,
    this.date_of_issued_cert_no,
    this.type_of_certificate,
    this.registered_number,
    this.cc_number,
    this.certicate_number,
    this.applicant_name,
    this.grantor_name,
    this.job_number,
    this.type_instrument,
    this.date_of_instument,
    this.consideration,
    this.purpose,
    this.date_commencement,
    this.term,
    this.remarks,
    this.plotted_by_reg,
    this.checked_by,
    this.plott_date_reg,
    this.type_of_registration,
    this.fid_id_fk,
    this.plan_number,
    this.encumbrance,
    this.status,
    this.reference_number,
    this.land_size,
  });

  @override
  String toString() {
    return 'TitleCertificateResponseModel{gid: $gid, nature_of_instument: $nature_of_instument, date_of_registration: $date_of_registration, volume: $volume, date_of_issued_cert_no: $date_of_issued_cert_no, type_of_certificate: $type_of_certificate, registered_number: $registered_number, cc_number: $cc_number, certicate_number: $certicate_number, applicant_name: $applicant_name, grantor_name: $grantor_name, job_number: $job_number, type_instrument: $type_instrument, date_of_instument: $date_of_instument, consideration: $consideration, purpose: $purpose, date_commencement: $date_commencement, term: $term, remarks: $remarks, plotted_by_reg: $plotted_by_reg, checked_by: $checked_by, plott_date_reg: $plott_date_reg, type_of_registration: $type_of_registration, fid_id_fk: $fid_id_fk, plan_number: $plan_number, encumbrance: $encumbrance, status: $status, reference_number: $reference_number, land_size: $land_size}';
  }
}
