// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUp_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      password: json['password'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'userName': instance.userName,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
    };
