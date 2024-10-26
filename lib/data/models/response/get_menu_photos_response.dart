import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'get_menu_photos_response.g.dart';

@JsonSerializable()
class GetMenuPhotosResponse with EquatableMixin {
  bool? status;
  Menus? menus;

  GetMenuPhotosResponse({
    this.status,
    this.menus,
  });

  factory GetMenuPhotosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMenuPhotosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMenuPhotosResponseToJson(this);

  @override
  List<Object?> get props => [status, menus];

  GetMenuPhotosResponse copyWith({
    bool? status,
    Menus? menus,
  }) {
    return GetMenuPhotosResponse(
      status: status ?? this.status,
      menus: menus ?? this.menus,
    );
  }
}

@JsonSerializable()
class Menus with EquatableMixin {
  String? menu1;
  String? menu2;
  String? menu3;

  Menus({
    this.menu1,
    this.menu2,
    this.menu3,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);

  Map<String, dynamic> toJson() => _$MenusToJson(this);

  @override
  List<Object?> get props => [menu1, menu2, menu3];

  Menus copyWith({
    String? menu1,
    String? menu2,
    String? menu3,
  }) {
    return Menus(
      menu1: menu1 ?? this.menu1,
      menu2: menu2 ?? this.menu2,
      menu3: menu3 ?? this.menu3,
    );
  }
}
