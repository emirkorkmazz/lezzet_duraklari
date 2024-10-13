import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse with EquatableMixin {
  bool? status;
  User? user;

  LoginResponse({
    this.status,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props => [status, user];

  LoginResponse copyWith({
    bool? status,
    User? user,
  }) {
    return LoginResponse(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}

@JsonSerializable()
class User with EquatableMixin {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? role;
  int? isVerified;
  String? token;

  User({
    this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.role,
    this.isVerified,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props =>
      [id, email, name, phoneNumber, role, isVerified, token];

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? role,
    int? isVerified,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      token: token ?? this.token,
    );
  }
}
