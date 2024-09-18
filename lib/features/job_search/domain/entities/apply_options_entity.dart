import 'package:equatable/equatable.dart';

import '../../data/models/apply_options_model.dart';

class ApplyOptionEntity extends Equatable {
  final String? publisher;
  final String? applyLink;
  final bool? isDirect;

  ApplyOptionEntity({
    this.publisher,
    this.applyLink,
    this.isDirect,
  });

  @override
  List<Object?> get props => [publisher, applyLink, isDirect];

  ApplyOptionModel toModel() {
    return ApplyOptionModel(
      publisher: publisher,
      applyLink: applyLink,
      isDirect: isDirect,
    );
  }
}