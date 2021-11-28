import 'package:elandguard/model/MilestoneModel.dart';

class ApplicationDetailsModel {
  String client_name;
  String case_number;
  String job_status;
  String created_date;
  String modified_date;
  String business_process_name;
  String business_process_sub_name;
  String application_stage;
  List<MilestoneModel> milestones;

  ApplicationDetailsModel({
    this.client_name,
    this.case_number,
    this.job_status,
    this.created_date,
    this.modified_date,
    this.business_process_name,
    this.business_process_sub_name,
    this.application_stage,
    this.milestones,
  });

  Map<String, dynamic> toMap() {
    return {
      'client_name': client_name,
      'case_number': case_number,
      'job_status': job_status,
      'created_date': created_date,
      'modified_date': modified_date,
      'business_process_name': business_process_name,
      'business_process_sub_name': business_process_sub_name,
      'application_stage': application_stage,
      'milestones': milestones,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'client_name': client_name,
      'case_number': case_number,
      'job_status': job_status,
      'created_date': created_date,
      'modified_date': modified_date,
      'business_process_name': business_process_name,
      'business_process_sub_name': business_process_sub_name,
      'application_stage': application_stage,
      'milestones': milestones,
    };
  }

  @override
  String toString() {
    return 'ApplicationDetailsModel{client_name: $client_name, case_number: $case_number, job_status: $job_status, created_date: $created_date, modified_date: $modified_date, business_process_name: $business_process_name, business_process_sub_name: $business_process_sub_name, application_stage: $application_stage, milestones: $milestones}';
  }
}
