import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  ///
  const Failure({
    required this.message,
    this.status,
  });

  ///
  final String message;
  final String? status;

  @override
  List<Object?> get props => [
        message,
        status,
      ];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.status});
}
