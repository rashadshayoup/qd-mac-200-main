// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUp_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      json['firstName'] as String? ?? '',
      json['lastName'] as String? ?? '',
      json['address'] as String? ?? '',
      json['userName'] as String? ?? '',
      json['password'] as String? ?? '',
      json['phoneNumber'] as String? ?? '',
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
