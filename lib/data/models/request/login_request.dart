import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest with EquatableMixin {
  String? email;
  String? password;

  LoginRequest({
    this.email,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [email, password];

  LoginRequest copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
