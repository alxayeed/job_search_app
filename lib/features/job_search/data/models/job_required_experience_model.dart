import '../../domain/entities/job_required_experience_entity.dart';

class JobRequiredExperienceModel extends JobRequiredExperienceEntity {
  JobRequiredExperienceModel({
    bool? noExperienceRequired,
    int? requiredExperienceInMonths,
    bool? experienceMentioned,
    bool? experiencePreferred,
  }) : super(
          noExperienceRequired: noExperienceRequired,
          requiredExperienceInMonths: requiredExperienceInMonths,
          experienceMentioned: experienceMentioned,
          experiencePreferred: experiencePreferred,
        );

  factory JobRequiredExperienceModel.fromJson(Map<String, dynamic> json) {
    return JobRequiredExperienceModel(
      noExperienceRequired: json['no_experience_required'] == true ||
          json['no_experience_required'] == 'true',
      requiredExperienceInMonths: json['required_experience_in_months'] != null
          ? int.tryParse(json['required_experience_in_months'].toString())
          : null,
      experienceMentioned: json['experience_mentioned'] == true ||
          json['experience_mentioned'] == 'true',
      experiencePreferred: json['experience_preferred'] == true ||
          json['experience_preferred'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no_experience_required': noExperienceRequired,
      'required_experience_in_months': requiredExperienceInMonths,
      'experience_mentioned': experienceMentioned,
      'experience_preferred': experiencePreferred,
    };
  }

  JobRequiredExperienceEntity toEntity() {
    return JobRequiredExperienceEntity(
      noExperienceRequired: noExperienceRequired,
      requiredExperienceInMonths: requiredExperienceInMonths,
      experienceMentioned: experienceMentioned,
      experiencePreferred: experiencePreferred,
    );
  }
}
