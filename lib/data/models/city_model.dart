import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityContent {
  @JsonKey(name: 'content',defaultValue: [])
  List<CityContentPage> content;

  CityContent(this.content);

  factory CityContent.fromJson(Map<String, dynamic> json) => _$CityContentFromJson(json);
  Map<String, dynamic> toJson() => _$CityContentToJson(this);
}

@JsonSerializable()
class CityContentPage {
  @JsonKey(name: 'cities', defaultValue: [])
  final List<CityModel> cities;

  CityContentPage({required this.cities});

  factory CityContentPage.fromJson(Map<String, dynamic> json) => _$CityContentPageFromJson(json);
  Map<String, dynamic> toJson() => _$CityContentPageToJson(this);
}

@JsonSerializable()
class CityModel {
  @JsonKey(name: 'cityId', defaultValue: '')
  String cityId;
  @JsonKey(name: 'name', defaultValue: '')
  String name;
  @JsonKey(name: 'price', defaultValue: 0)
  num price;

  CityModel({required this.cityId, required this.name, required this.price});

  factory CityModel.fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
