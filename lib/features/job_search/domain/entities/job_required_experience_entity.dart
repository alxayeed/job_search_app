import 'package:equatable/equatable.dart';

import '../../data/models/job_required_experience_model.dart';

class JobRequiredExperienceEntity extends Equatable {
  final bool? noExperienceRequired;
  final int? requiredExperienceInMonths;
  final bool? experienceMentioned;
  final bool? experiencePreferred;

  JobRequiredExperienceEntity({
    this.noExperienceRequired,
    this.requiredExperienceInMonths,
    this.experienceMentioned,
    this.experiencePreferred,
  });

  @override
  List<Object?> get props => [
    noExperienceRequired,
    requiredExperienceInMonths,
    experienceMentioned,
    experiencePreferred,
  ];

  JobRequiredExperienceModel toModel() {
    return JobRequiredExperienceModel(
      noExperienceRequired: noExperienceRequired,
      requiredExperienceInMonths: requiredExperienceInMonths,
      experienceMentioned: experienceMentioned,
      experiencePreferred: experiencePreferred,
    );
  }
}
