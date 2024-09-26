import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(String message) : super(message);
}

class InputFailure extends Failure {
  const InputFailure(String message) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
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

// class DatabaseFailure extends Failure {
//   const DatabaseFailure(String message) : super(message);
// }
//
// class ThirdPartyServiceFailure extends Failure {
//   const ThirdPartyServiceFailure(String message) : super(message);
// }
//
// class AuthenticationFailure extends Failure {
//   const AuthenticationFailure(String message) : super(message);
// }
//
// class PermissionFailure extends Failure {
//   const PermissionFailure(String message) : super(message);
// }
