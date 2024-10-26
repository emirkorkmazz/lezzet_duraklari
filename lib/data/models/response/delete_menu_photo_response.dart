import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'delete_menu_photo_response.g.dart';

@JsonSerializable()
class DeleteMenuPhotoResponse with EquatableMixin {
  bool? status;
  String? message;

  DeleteMenuPhotoResponse({
    this.status,
    this.message,
  });

  factory DeleteMenuPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteMenuPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteMenuPhotoResponseToJson(this);

  @override
  List<Object?> get props => [status, message];

  DeleteMenuPhotoResponse copyWith({
    bool? status,
    String? message,
  }) {
    return DeleteMenuPhotoResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
