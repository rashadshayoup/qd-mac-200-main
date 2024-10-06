import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_model.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: 'oldPassWord', defaultValue: '')
  String oldPassWord;
  @JsonKey(name: 'newPassWord', defaultValue: '')
  String newPassWord;
  @JsonKey(name: 'confirmNewPassWord', defaultValue: '')
  String confirmNewPassWord;

  ChangePasswordRequest({
    required this.oldPassWord,
    required this.newPassWord,
    required this.confirmNewPassWord,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}

// {
// "firstName": "string",
// "lastName": "string",
// "address": "string",
// "userName": "string",
// "password": "string",
// "phoneNumber": "string"
// }
