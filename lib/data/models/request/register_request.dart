import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest extends Equatable {
  final String email;
  final String name;
  final String surname;
  final String password;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String role;

  const RegisterRequest({
    required this.email,
    required this.name,
    required this.surname,
    required this.password,
    required this.phoneNumber,
    required this.role,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  List<Object?> get props =>
      [email, name, surname, password, phoneNumber, role];

  RegisterRequest copyWith({
    String? email,
    String? name,
    String? surname,
    String? password,
    String? phoneNumber,
    String? role,
  }) {
    return RegisterRequest(
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }
}
