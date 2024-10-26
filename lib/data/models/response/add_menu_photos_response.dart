import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'add_menu_photos_response.g.dart';

@JsonSerializable()
class AddMenuPhotosResponse with EquatableMixin {
  bool? status;
  String? message;
  List<String>? updatedMenus;

  AddMenuPhotosResponse({
    this.status,
    this.message,
    this.updatedMenus,
  });

  factory AddMenuPhotosResponse.fromJson(Map<String, dynamic> json) =>
      _$AddMenuPhotosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddMenuPhotosResponseToJson(this);

  @override
  List<Object?> get props => [status, message, updatedMenus];

  AddMenuPhotosResponse copyWith({
    bool? status,
    String? message,
    List<String>? updatedMenus,
  }) {
    return AddMenuPhotosResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      updatedMenus: updatedMenus ?? this.updatedMenus,
    );
  }
}
