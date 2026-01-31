// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobEntity {
  String get jobId;
  String? get employerName;
  String? get employerLogo;
  String? get employerWebsite;
  String? get jobTitle;
  String? get jobDescription;
  String? get jobApplyLink;
  bool? get jobIsRemote;
  bool? get jobApplyIsDirect;
  String? get jobCity;
  EmploymentType? get employmentType;
  JobCountry? get country;
  JobExperience? get experience;
  DatePosted? get datePosted;
  String? get jobSalaryCurrency;
  String? get jobSalaryPeriod;
  JobHighlightsEntity? get jobHighlights;
  List<ApplyOptionEntity>? get applyOptions;
  DateTime? get jobPostedAtUtc;
  bool get isBookmarked;

  /// Create a copy of JobEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JobEntityCopyWith<JobEntity> get copyWith =>
      _$JobEntityCopyWithImpl<JobEntity>(this as JobEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JobEntity &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.employerName, employerName) ||
                other.employerName == employerName) &&
            (identical(other.employerLogo, employerLogo) ||
                other.employerLogo == employerLogo) &&
            (identical(other.employerWebsite, employerWebsite) ||
                other.employerWebsite == employerWebsite) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.jobDescription, jobDescription) ||
                other.jobDescription == jobDescription) &&
            (identical(other.jobApplyLink, jobApplyLink) ||
                other.jobApplyLink == jobApplyLink) &&
            (identical(other.jobIsRemote, jobIsRemote) ||
                other.jobIsRemote == jobIsRemote) &&
            (identical(other.jobApplyIsDirect, jobApplyIsDirect) ||
                other.jobApplyIsDirect == jobApplyIsDirect) &&
            (identical(other.jobCity, jobCity) || other.jobCity == jobCity) &&
            (identical(other.employmentType, employmentType) ||
                other.employmentType == employmentType) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.datePosted, datePosted) ||
                other.datePosted == datePosted) &&
            (identical(other.jobSalaryCurrency, jobSalaryCurrency) ||
                other.jobSalaryCurrency == jobSalaryCurrency) &&
            (identical(other.jobSalaryPeriod, jobSalaryPeriod) ||
                other.jobSalaryPeriod == jobSalaryPeriod) &&
            (identical(other.jobHighlights, jobHighlights) ||
                other.jobHighlights == jobHighlights) &&
            const DeepCollectionEquality()
                .equals(other.applyOptions, applyOptions) &&
            (identical(other.jobPostedAtUtc, jobPostedAtUtc) ||
                other.jobPostedAtUtc == jobPostedAtUtc) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        jobId,
        employerName,
        employerLogo,
        employerWebsite,
        jobTitle,
        jobDescription,
        jobApplyLink,
        jobIsRemote,
        jobApplyIsDirect,
        jobCity,
        employmentType,
        country,
        experience,
        datePosted,
        jobSalaryCurrency,
        jobSalaryPeriod,
        jobHighlights,
        const DeepCollectionEquality().hash(applyOptions),
        jobPostedAtUtc,
        isBookmarked
      ]);

  @override
  String toString() {
    return 'JobEntity(jobId: $jobId, employerName: $employerName, employerLogo: $employerLogo, employerWebsite: $employerWebsite, jobTitle: $jobTitle, jobDescription: $jobDescription, jobApplyLink: $jobApplyLink, jobIsRemote: $jobIsRemote, jobApplyIsDirect: $jobApplyIsDirect, jobCity: $jobCity, employmentType: $employmentType, country: $country, experience: $experience, datePosted: $datePosted, jobSalaryCurrency: $jobSalaryCurrency, jobSalaryPeriod: $jobSalaryPeriod, jobHighlights: $jobHighlights, applyOptions: $applyOptions, jobPostedAtUtc: $jobPostedAtUtc, isBookmarked: $isBookmarked)';
  }
}

/// @nodoc
abstract mixin class $JobEntityCopyWith<$Res> {
  factory $JobEntityCopyWith(JobEntity value, $Res Function(JobEntity) _then) =
      _$JobEntityCopyWithImpl;
  @useResult
  $Res call(
      {String jobId,
      String? employerName,
      String? employerLogo,
      String? employerWebsite,
      String? jobTitle,
      String? jobDescription,
      String? jobApplyLink,
      bool? jobIsRemote,
      bool? jobApplyIsDirect,
      String? jobCity,
      EmploymentType? employmentType,
      JobCountry? country,
      JobExperience? experience,
      DatePosted? datePosted,
      String? jobSalaryCurrency,
      String? jobSalaryPeriod,
      JobHighlightsEntity? jobHighlights,
      List<ApplyOptionEntity>? applyOptions,
      DateTime? jobPostedAtUtc,
      bool isBookmarked});
}

/// @nodoc
class _$JobEntityCopyWithImpl<$Res> implements $JobEntityCopyWith<$Res> {
  _$JobEntityCopyWithImpl(this._self, this._then);

  final JobEntity _self;
  final $Res Function(JobEntity) _then;

  /// Create a copy of JobEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobId = null,
    Object? employerName = freezed,
    Object? employerLogo = freezed,
    Object? employerWebsite = freezed,
    Object? jobTitle = freezed,
    Object? jobDescription = freezed,
    Object? jobApplyLink = freezed,
    Object? jobIsRemote = freezed,
    Object? jobApplyIsDirect = freezed,
    Object? jobCity = freezed,
    Object? employmentType = freezed,
    Object? country = freezed,
    Object? experience = freezed,
    Object? datePosted = freezed,
    Object? jobSalaryCurrency = freezed,
    Object? jobSalaryPeriod = freezed,
    Object? jobHighlights = freezed,
    Object? applyOptions = freezed,
    Object? jobPostedAtUtc = freezed,
    Object? isBookmarked = null,
  }) {
    return _then(_self.copyWith(
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      employerName: freezed == employerName
          ? _self.employerName
          : employerName // ignore: cast_nullable_to_non_nullable
              as String?,
      employerLogo: freezed == employerLogo
          ? _self.employerLogo
          : employerLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      employerWebsite: freezed == employerWebsite
          ? _self.employerWebsite
          : employerWebsite // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: freezed == jobTitle
          ? _self.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobDescription: freezed == jobDescription
          ? _self.jobDescription
          : jobDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      jobApplyLink: freezed == jobApplyLink
          ? _self.jobApplyLink
          : jobApplyLink // ignore: cast_nullable_to_non_nullable
              as String?,
      jobIsRemote: freezed == jobIsRemote
          ? _self.jobIsRemote
          : jobIsRemote // ignore: cast_nullable_to_non_nullable
              as bool?,
      jobApplyIsDirect: freezed == jobApplyIsDirect
          ? _self.jobApplyIsDirect
          : jobApplyIsDirect // ignore: cast_nullable_to_non_nullable
              as bool?,
      jobCity: freezed == jobCity
          ? _self.jobCity
          : jobCity // ignore: cast_nullable_to_non_nullable
              as String?,
      employmentType: freezed == employmentType
          ? _self.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as EmploymentType?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as JobCountry?,
      experience: freezed == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as JobExperience?,
      datePosted: freezed == datePosted
          ? _self.datePosted
          : datePosted // ignore: cast_nullable_to_non_nullable
              as DatePosted?,
      jobSalaryCurrency: freezed == jobSalaryCurrency
          ? _self.jobSalaryCurrency
          : jobSalaryCurrency // ignore: cast_nullable_to_non_nullable
              as String?,
      jobSalaryPeriod: freezed == jobSalaryPeriod
          ? _self.jobSalaryPeriod
          : jobSalaryPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      jobHighlights: freezed == jobHighlights
          ? _self.jobHighlights
          : jobHighlights // ignore: cast_nullable_to_non_nullable
              as JobHighlightsEntity?,
      applyOptions: freezed == applyOptions
          ? _self.applyOptions
          : applyOptions // ignore: cast_nullable_to_non_nullable
              as List<ApplyOptionEntity>?,
      jobPostedAtUtc: freezed == jobPostedAtUtc
          ? _self.jobPostedAtUtc
          : jobPostedAtUtc // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isBookmarked: null == isBookmarked
          ? _self.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [JobEntity].
extension JobEntityPatterns on JobEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_JobEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JobEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_JobEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobEntity():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_JobEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String jobId,
            String? employerName,
            String? employerLogo,
            String? employerWebsite,
            String? jobTitle,
            String? jobDescription,
            String? jobApplyLink,
            bool? jobIsRemote,
            bool? jobApplyIsDirect,
            String? jobCity,
            EmploymentType? employmentType,
            JobCountry? country,
            JobExperience? experience,
            DatePosted? datePosted,
            String? jobSalaryCurrency,
            String? jobSalaryPeriod,
            JobHighlightsEntity? jobHighlights,
            List<ApplyOptionEntity>? applyOptions,
            DateTime? jobPostedAtUtc,
            bool isBookmarked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JobEntity() when $default != null:
        return $default(
            _that.jobId,
            _that.employerName,
            _that.employerLogo,
            _that.employerWebsite,
            _that.jobTitle,
            _that.jobDescription,
            _that.jobApplyLink,
            _that.jobIsRemote,
            _that.jobApplyIsDirect,
            _that.jobCity,
            _that.employmentType,
            _that.country,
            _that.experience,
            _that.datePosted,
            _that.jobSalaryCurrency,
            _that.jobSalaryPeriod,
            _that.jobHighlights,
            _that.applyOptions,
            _that.jobPostedAtUtc,
            _that.isBookmarked);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String jobId,
            String? employerName,
            String? employerLogo,
            String? employerWebsite,
            String? jobTitle,
            String? jobDescription,
            String? jobApplyLink,
            bool? jobIsRemote,
            bool? jobApplyIsDirect,
            String? jobCity,
            EmploymentType? employmentType,
            JobCountry? country,
            JobExperience? experience,
            DatePosted? datePosted,
            String? jobSalaryCurrency,
            String? jobSalaryPeriod,
            JobHighlightsEntity? jobHighlights,
            List<ApplyOptionEntity>? applyOptions,
            DateTime? jobPostedAtUtc,
            bool isBookmarked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobEntity():
        return $default(
            _that.jobId,
            _that.employerName,
            _that.employerLogo,
            _that.employerWebsite,
            _that.jobTitle,
            _that.jobDescription,
            _that.jobApplyLink,
            _that.jobIsRemote,
            _that.jobApplyIsDirect,
            _that.jobCity,
            _that.employmentType,
            _that.country,
            _that.experience,
            _that.datePosted,
            _that.jobSalaryCurrency,
            _that.jobSalaryPeriod,
            _that.jobHighlights,
            _that.applyOptions,
            _that.jobPostedAtUtc,
            _that.isBookmarked);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String jobId,
            String? employerName,
            String? employerLogo,
            String? employerWebsite,
            String? jobTitle,
            String? jobDescription,
            String? jobApplyLink,
            bool? jobIsRemote,
            bool? jobApplyIsDirect,
            String? jobCity,
            EmploymentType? employmentType,
            JobCountry? country,
            JobExperience? experience,
            DatePosted? datePosted,
            String? jobSalaryCurrency,
            String? jobSalaryPeriod,
            JobHighlightsEntity? jobHighlights,
            List<ApplyOptionEntity>? applyOptions,
            DateTime? jobPostedAtUtc,
            bool isBookmarked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobEntity() when $default != null:
        return $default(
            _that.jobId,
            _that.employerName,
            _that.employerLogo,
            _that.employerWebsite,
            _that.jobTitle,
            _that.jobDescription,
            _that.jobApplyLink,
            _that.jobIsRemote,
            _that.jobApplyIsDirect,
            _that.jobCity,
            _that.employmentType,
            _that.country,
            _that.experience,
            _that.datePosted,
            _that.jobSalaryCurrency,
            _that.jobSalaryPeriod,
            _that.jobHighlights,
            _that.applyOptions,
            _that.jobPostedAtUtc,
            _that.isBookmarked);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _JobEntity extends JobEntity {
  const _JobEntity(
      {required this.jobId,
      this.employerName,
      this.employerLogo,
      this.employerWebsite,
      this.jobTitle,
      this.jobDescription,
      this.jobApplyLink,
      this.jobIsRemote,
      this.jobApplyIsDirect,
      this.jobCity,
      this.employmentType,
      this.country,
      this.experience,
      this.datePosted,
      this.jobSalaryCurrency,
      this.jobSalaryPeriod,
      this.jobHighlights,
      final List<ApplyOptionEntity>? applyOptions,
      this.jobPostedAtUtc,
      this.isBookmarked = false})
      : _applyOptions = applyOptions,
        super._();

  @override
  final String jobId;
  @override
  final String? employerName;
  @override
  final String? employerLogo;
  @override
  final String? employerWebsite;
  @override
  final String? jobTitle;
  @override
  final String? jobDescription;
  @override
  final String? jobApplyLink;
  @override
  final bool? jobIsRemote;
  @override
  final bool? jobApplyIsDirect;
  @override
  final String? jobCity;
  @override
  final EmploymentType? employmentType;
  @override
  final JobCountry? country;
  @override
  final JobExperience? experience;
  @override
  final DatePosted? datePosted;
  @override
  final String? jobSalaryCurrency;
  @override
  final String? jobSalaryPeriod;
  @override
  final JobHighlightsEntity? jobHighlights;
  final List<ApplyOptionEntity>? _applyOptions;
  @override
  List<ApplyOptionEntity>? get applyOptions {
    final value = _applyOptions;
    if (value == null) return null;
    if (_applyOptions is EqualUnmodifiableListView) return _applyOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? jobPostedAtUtc;
  @override
  @JsonKey()
  final bool isBookmarked;

  /// Create a copy of JobEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JobEntityCopyWith<_JobEntity> get copyWith =>
      __$JobEntityCopyWithImpl<_JobEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JobEntity &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.employerName, employerName) ||
                other.employerName == employerName) &&
            (identical(other.employerLogo, employerLogo) ||
                other.employerLogo == employerLogo) &&
            (identical(other.employerWebsite, employerWebsite) ||
                other.employerWebsite == employerWebsite) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.jobDescription, jobDescription) ||
                other.jobDescription == jobDescription) &&
            (identical(other.jobApplyLink, jobApplyLink) ||
                other.jobApplyLink == jobApplyLink) &&
            (identical(other.jobIsRemote, jobIsRemote) ||
                other.jobIsRemote == jobIsRemote) &&
            (identical(other.jobApplyIsDirect, jobApplyIsDirect) ||
                other.jobApplyIsDirect == jobApplyIsDirect) &&
            (identical(other.jobCity, jobCity) || other.jobCity == jobCity) &&
            (identical(other.employmentType, employmentType) ||
                other.employmentType == employmentType) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.datePosted, datePosted) ||
                other.datePosted == datePosted) &&
            (identical(other.jobSalaryCurrency, jobSalaryCurrency) ||
                other.jobSalaryCurrency == jobSalaryCurrency) &&
            (identical(other.jobSalaryPeriod, jobSalaryPeriod) ||
                other.jobSalaryPeriod == jobSalaryPeriod) &&
            (identical(other.jobHighlights, jobHighlights) ||
                other.jobHighlights == jobHighlights) &&
            const DeepCollectionEquality()
                .equals(other._applyOptions, _applyOptions) &&
            (identical(other.jobPostedAtUtc, jobPostedAtUtc) ||
                other.jobPostedAtUtc == jobPostedAtUtc) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        jobId,
        employerName,
        employerLogo,
        employerWebsite,
        jobTitle,
        jobDescription,
        jobApplyLink,
        jobIsRemote,
        jobApplyIsDirect,
        jobCity,
        employmentType,
        country,
        experience,
        datePosted,
        jobSalaryCurrency,
        jobSalaryPeriod,
        jobHighlights,
        const DeepCollectionEquality().hash(_applyOptions),
        jobPostedAtUtc,
        isBookmarked
      ]);

  @override
  String toString() {
    return 'JobEntity(jobId: $jobId, employerName: $employerName, employerLogo: $employerLogo, employerWebsite: $employerWebsite, jobTitle: $jobTitle, jobDescription: $jobDescription, jobApplyLink: $jobApplyLink, jobIsRemote: $jobIsRemote, jobApplyIsDirect: $jobApplyIsDirect, jobCity: $jobCity, employmentType: $employmentType, country: $country, experience: $experience, datePosted: $datePosted, jobSalaryCurrency: $jobSalaryCurrency, jobSalaryPeriod: $jobSalaryPeriod, jobHighlights: $jobHighlights, applyOptions: $applyOptions, jobPostedAtUtc: $jobPostedAtUtc, isBookmarked: $isBookmarked)';
  }
}

/// @nodoc
abstract mixin class _$JobEntityCopyWith<$Res>
    implements $JobEntityCopyWith<$Res> {
  factory _$JobEntityCopyWith(
          _JobEntity value, $Res Function(_JobEntity) _then) =
      __$JobEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String jobId,
      String? employerName,
      String? employerLogo,
      String? employerWebsite,
      String? jobTitle,
      String? jobDescription,
      String? jobApplyLink,
      bool? jobIsRemote,
      bool? jobApplyIsDirect,
      String? jobCity,
      EmploymentType? employmentType,
      JobCountry? country,
      JobExperience? experience,
      DatePosted? datePosted,
      String? jobSalaryCurrency,
      String? jobSalaryPeriod,
      JobHighlightsEntity? jobHighlights,
      List<ApplyOptionEntity>? applyOptions,
      DateTime? jobPostedAtUtc,
      bool isBookmarked});
}

/// @nodoc
class __$JobEntityCopyWithImpl<$Res> implements _$JobEntityCopyWith<$Res> {
  __$JobEntityCopyWithImpl(this._self, this._then);

  final _JobEntity _self;
  final $Res Function(_JobEntity) _then;

  /// Create a copy of JobEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? jobId = null,
    Object? employerName = freezed,
    Object? employerLogo = freezed,
    Object? employerWebsite = freezed,
    Object? jobTitle = freezed,
    Object? jobDescription = freezed,
    Object? jobApplyLink = freezed,
    Object? jobIsRemote = freezed,
    Object? jobApplyIsDirect = freezed,
    Object? jobCity = freezed,
    Object? employmentType = freezed,
    Object? country = freezed,
    Object? experience = freezed,
    Object? datePosted = freezed,
    Object? jobSalaryCurrency = freezed,
    Object? jobSalaryPeriod = freezed,
    Object? jobHighlights = freezed,
    Object? applyOptions = freezed,
    Object? jobPostedAtUtc = freezed,
    Object? isBookmarked = null,
  }) {
    return _then(_JobEntity(
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      employerName: freezed == employerName
          ? _self.employerName
          : employerName // ignore: cast_nullable_to_non_nullable
              as String?,
      employerLogo: freezed == employerLogo
          ? _self.employerLogo
          : employerLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      employerWebsite: freezed == employerWebsite
          ? _self.employerWebsite
          : employerWebsite // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: freezed == jobTitle
          ? _self.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobDescription: freezed == jobDescription
          ? _self.jobDescription
          : jobDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      jobApplyLink: freezed == jobApplyLink
          ? _self.jobApplyLink
          : jobApplyLink // ignore: cast_nullable_to_non_nullable
              as String?,
      jobIsRemote: freezed == jobIsRemote
          ? _self.jobIsRemote
          : jobIsRemote // ignore: cast_nullable_to_non_nullable
              as bool?,
      jobApplyIsDirect: freezed == jobApplyIsDirect
          ? _self.jobApplyIsDirect
          : jobApplyIsDirect // ignore: cast_nullable_to_non_nullable
              as bool?,
      jobCity: freezed == jobCity
          ? _self.jobCity
          : jobCity // ignore: cast_nullable_to_non_nullable
              as String?,
      employmentType: freezed == employmentType
          ? _self.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as EmploymentType?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as JobCountry?,
      experience: freezed == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as JobExperience?,
      datePosted: freezed == datePosted
          ? _self.datePosted
          : datePosted // ignore: cast_nullable_to_non_nullable
              as DatePosted?,
      jobSalaryCurrency: freezed == jobSalaryCurrency
          ? _self.jobSalaryCurrency
          : jobSalaryCurrency // ignore: cast_nullable_to_non_nullable
              as String?,
      jobSalaryPeriod: freezed == jobSalaryPeriod
          ? _self.jobSalaryPeriod
          : jobSalaryPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      jobHighlights: freezed == jobHighlights
          ? _self.jobHighlights
          : jobHighlights // ignore: cast_nullable_to_non_nullable
              as JobHighlightsEntity?,
      applyOptions: freezed == applyOptions
          ? _self._applyOptions
          : applyOptions // ignore: cast_nullable_to_non_nullable
              as List<ApplyOptionEntity>?,
      jobPostedAtUtc: freezed == jobPostedAtUtc
          ? _self.jobPostedAtUtc
          : jobPostedAtUtc // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isBookmarked: null == isBookmarked
          ? _self.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
