import 'package:equatable/equatable.dart';

abstract class JobFailure extends Equatable {
  const JobFailure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends JobFailure {
  final String message;

  ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends JobFailure {
  final String message;

  CacheFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class InputFailure extends JobFailure {
  final String message;

  InputFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class BookmarkFailure extends JobFailure {
  final String message;

  BookmarkFailure(this.message);

  @override
  List<Object?> get props => [message];
}


