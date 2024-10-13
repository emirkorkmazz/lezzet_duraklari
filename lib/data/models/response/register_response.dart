import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse with EquatableMixin {
  bool? status;
  String? message;

  RegisterResponse({
    this.status,
    this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  @override
  List<Object?> get props => [status, message];

  RegisterResponse copyWith({
    bool? status,
    String? message,
  }) {
    return RegisterResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
