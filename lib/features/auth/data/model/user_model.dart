import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  String username;
  String email;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'],
  //     username: map['username'],
  //     email: map['email'],
  //   );
  // }
  //
  // Map<String, dynamic> toMap() {
  //   return {
  //   'id': id,
  //   'username': username,
  //   'email': email,
  //   };
  // }


  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
