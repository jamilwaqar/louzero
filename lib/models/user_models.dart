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
  @JsonKey(defaultValue: '')   String activeCompanyId = '';
  @JsonKey(defaultValue: [])   List<String> customerTypes = [];
  @JsonKey(defaultValue: [])   List<String> jobTypes = [];

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
    var created = map['created'];
    DateTime? date;
    if (created is! DateTime) {
      date = DateTime.fromMillisecondsSinceEpoch(created);
      map.remove('created');
    } else {
      map.remove('created');
    }

    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    var model = InviteModel.fromJson(json);
    if (date != null) {
      model.created = date;
    } else {
      model.created = created;
    }
    return model;
  }

  Map<String, dynamic> toJson() => _$InviteModelToJson(this);
}