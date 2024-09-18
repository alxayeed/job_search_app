import '../../domain/entities/apply_options_entity.dart';

class ApplyOptionModel extends ApplyOptionEntity {
  ApplyOptionModel({
    String? publisher,
    String? applyLink,
    bool? isDirect,
  }) : super(
          publisher: publisher,
          applyLink: applyLink,
          isDirect: isDirect,
        );

  factory ApplyOptionModel.fromJson(Map<String, dynamic> json) {
    return ApplyOptionModel(
      publisher: json['publisher'],
      applyLink: json['apply_link'],
      isDirect: json['is_direct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'publisher': publisher,
      'apply_link': applyLink,
      'is_direct': isDirect,
    };
  }

  ApplyOptionEntity toEntity() {
    return ApplyOptionEntity(
      publisher: publisher,
      applyLink: applyLink,
      isDirect: isDirect,
    );
  }
}
