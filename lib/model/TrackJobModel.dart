class TrackJobModel {
  String job_number;

  TrackJobModel({
    this.job_number,
  });

  Map<String, dynamic> toMap() {
    return {
      'job_number': job_number,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'job_number': job_number,
    };
  }

  @override
  String toString() {
    return 'TrackJobModel{job_number: $job_number}';
  }
}
