import 'package:equatable/equatable.dart';

import '../../data/models/job_highlights_model.dart';

class JobHighlightsEntity extends Equatable {
  final List<String>? qualifications;
  final List<String>? responsibilities;

  JobHighlightsEntity({
    this.qualifications,
    this.responsibilities,
  });

  @override
  List<Object?> get props => [qualifications, responsibilities];

  JobHighlightsModel toModel() {
    return JobHighlightsModel(
      qualifications: qualifications,
      responsibilities: responsibilities,
    );
  }
}
