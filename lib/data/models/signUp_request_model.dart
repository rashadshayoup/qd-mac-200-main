import 'package:json_annotation/json_annotation.dart';

part 'signUp_request_model.g.dart';

@JsonSerializable()
class SignUpRequest {
  @JsonKey(name: 'firstName', defaultValue: '')
  String firstName;
  @JsonKey(name: 'lastName', defaultValue: '')
  String lastName;
  @JsonKey(name: 'address', defaultValue: '')
  String address;
  @JsonKey(name: 'userName', defaultValue: '')
  String userName;
  @JsonKey(name: 'password', defaultValue: '')
  String password;
  @JsonKey(name: 'phoneNumber', defaultValue: '')
  String phoneNumber;

  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.userName,
    required this.password,
    required this.phoneNumber,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

// {
// "firstName": "string",
// "lastName": "string",
// "address": "string",
// "userName": "string",
// "password": "string",
// "phoneNumber": "string"
// }
