// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderContent _$OrderContentFromJson(Map<String, dynamic> json) => OrderContent(
      (json['content'] as List<dynamic>?)
              ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderContentToJson(OrderContent instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['orderId'] as String? ?? '',
      json['orderNo'] as String? ?? '',
      (json['orderState'] as num?)?.toInt() ?? 0,
      json['dscription'] as String? ?? '',
      json['recipientAddress'] as String? ?? '',
      (json['countOfItems'] as num?)?.toInt() ?? 0,
      json['senderPhoneNo'] as String? ?? '',
      json['recipientPhoneNo'] as String? ?? '',
      (json['price'] as num?)?.toDouble() ?? 0,
      (json['orderPrice'] as num?)?.toDouble() ?? 0,
      json['representative'] == null
          ? null
          : Representative.fromJson(
              json['representative'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNo': instance.orderNo,
      'orderState': instance.orderState,
      'dscription': instance.description,
      'recipientAddress': instance.recipientAddress,
      'countOfItems': instance.countOfItems,
      'senderPhoneNo': instance.senderPhoneNo,
      'recipientPhoneNo': instance.recipientPhoneNo,
      'price': instance.price,
      'orderPrice': instance.orderPrice,
      'representative': instance.representative,
    };

Representative _$RepresentativeFromJson(Map<String, dynamic> json) =>
    Representative(
      json['name'] as String? ?? '',
      json['phoneNumber'] as String? ?? '',
    );

Map<String, dynamic> _$RepresentativeToJson(Representative instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
    };
