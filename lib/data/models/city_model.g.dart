// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityContent _$CityContentFromJson(Map<String, dynamic> json) => CityContent(
      (json['content'] as List<dynamic>?)
              ?.map((e) => CityContentPage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CityContentToJson(CityContent instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

CityContentPage _$CityContentPageFromJson(Map<String, dynamic> json) =>
    CityContentPage(
      cities: (json['cities'] as List<dynamic>?)
              ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CityContentPageToJson(CityContentPage instance) =>
    <String, dynamic>{
      'cities': instance.cities,
    };

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      cityId: json['cityId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as num? ?? 0,
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'cityId': instance.cityId,
      'name': instance.name,
      'price': instance.price,
    };
