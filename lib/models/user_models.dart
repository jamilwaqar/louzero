import 'package:json_annotation/json_annotation.dart';
part 'user_models.g.dart';

@JsonSerializable()
class UserModel {
  UserModel();

  Uri? avatar;
  @JsonKey(defaultValue: '')   String email = '';
  @JsonKey(ignore: true)       String? objectId;
  @JsonKey(defaultValue: '')   String firstname = '';
  @JsonKey(defaultValue: '')   String lastname = '';

  String get fullName => "$firstname $lastname";
  String get initials {
    try {
      return "${fullName[0]}${lastname[0]}";
    } catch(e) {
      return '';
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class InviteModel {
  InviteModel();

  @JsonKey(defaultValue: '')   String email = '';
  String? objectId;
  @JsonKey(defaultValue: '')   String inviteCode = '';
  DateTime? created;

  factory InviteModel.fromJson(Map<String, dynamic> json) =>
      _$InviteModelFromJson(json);

  factory InviteModel.fromMap(Map map) {
    int created = map['created'];
    var date = DateTime.fromMillisecondsSinceEpoch(created);
    map.remove('created');
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    var model = InviteModel.fromJson(json);
    model.created = date;
    return model;
  }

  Map<String, dynamic> toJson() => _$InviteModelToJson(this);
}