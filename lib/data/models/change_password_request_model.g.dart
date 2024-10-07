// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      oldPassWord: json['oldPassWord'] as String? ?? '',
      newPassWord: json['newPassWord'] as String? ?? '',
      confirmNewPassWord: json['confirmNewPassWord'] as String? ?? '',
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'oldPassWord': instance.oldPassWord,
      'newPassWord': instance.newPassWord,
      'confirmNewPassWord': instance.confirmNewPassWord,
    };
