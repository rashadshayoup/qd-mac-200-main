// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_state_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeStateRequestRequest _$ChangeStateRequestRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeStateRequestRequest(
      orderNo: json['orderNo'] as String,
      orderState: (json['orderState'] as num).toInt(),
    );

Map<String, dynamic> _$ChangeStateRequestRequestToJson(
        ChangeStateRequestRequest instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'orderState': instance.orderState,
    };
