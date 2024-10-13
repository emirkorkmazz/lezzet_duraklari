import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest with EquatableMixin {
  String? email;
  String? password;
  String? name;
  String? phoneNumber;

  RegisterRequest({
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  List<Object?> get props => [email, password, name, phoneNumber];

  RegisterRequest copyWith({
    String? email,
    String? password,
    String? name,
    String? phoneNumber,
  }) {
    return RegisterRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
