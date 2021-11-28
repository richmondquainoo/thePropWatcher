class MilestoneModel {
  int ms_id;
  String milestone_description;
  String mile_stone_status;
  int working_day_required;
  String milestone_remaining;

  MilestoneModel({
    this.ms_id,
    this.milestone_description,
    this.working_day_required,
    this.mile_stone_status,
    this.milestone_remaining,
  });

  Map<String, dynamic> toMap() {
    return {
      'ms_id': ms_id,
      'milestone_description': milestone_description,
      'mile_stone_status': mile_stone_status,
      'working_day_required': working_day_required,
      'milestone_remaining': milestone_remaining,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'ms_id': ms_id,
      'milestone_description': milestone_description,
      'mile_stone_status': mile_stone_status,
      'working_day_required': working_day_required,
      'milestone_remaining': milestone_remaining,
    };
  }

  @override
  String toString() {
    return 'MilestoneModel{ms_id: $ms_id, milestone_description: $milestone_description, mile_stone_status: $mile_stone_status, working_day_required: $working_day_required, milestone_remaining: $milestone_remaining}';
  }
}
