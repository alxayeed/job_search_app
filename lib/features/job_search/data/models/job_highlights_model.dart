import '../../domain/entities/job_highlights_entity.dart';

class JobHighlightsModel extends JobHighlightsEntity {
  JobHighlightsModel({
    List<String>? qualifications,
    List<String>? responsibilities,
  }) : super(
          qualifications: qualifications,
          responsibilities: responsibilities,
        );

  factory JobHighlightsModel.fromJson(Map<String, dynamic> json) {
    return JobHighlightsModel(
      qualifications: (json['Qualifications'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      responsibilities: (json['Responsibilities'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Qualifications': qualifications,
      'Responsibilities': responsibilities,
    };
  }

  JobHighlightsEntity toEntity() {
    return JobHighlightsEntity(
      qualifications: qualifications,
      responsibilities: responsibilities,
    );
  }
}
