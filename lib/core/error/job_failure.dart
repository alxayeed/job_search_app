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

class NetworkFailure extends JobFailure {
  final String message;

  NetworkFailure(this.message);

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

// New custom exceptions
class ConnectionFailure extends NetworkFailure {
  ConnectionFailure(String message) : super(message);
}

class TimeoutFailure extends NetworkFailure {
  TimeoutFailure(String message) : super(message);
}

class RateLimitExceededFailure extends ServerFailure {
  RateLimitExceededFailure(String message) : super(message);
}

class NotFoundFailure extends ServerFailure {
  NotFoundFailure(String message) : super(message);
}

class RequestCancelledFailure extends NetworkFailure {
  RequestCancelledFailure(String message) : super(message);
}

class UnknownFailure extends JobFailure {
  final String message;

  UnknownFailure(this.message);

  @override
  List<Object?> get props => [message];
}
