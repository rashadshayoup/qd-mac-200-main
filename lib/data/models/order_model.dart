import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderContent {
  @JsonKey(name: "content", defaultValue: [])
  final List<OrderModel> content;

  OrderContent(this.content);

  factory OrderContent.fromJson(Map<String, dynamic> json) =>
      _$OrderContentFromJson(json);
  Map<String, dynamic> toJson() => _$OrderContentToJson(this);
}

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "orderId", defaultValue: '')
  final String orderId;
  @JsonKey(name: "orderNo", defaultValue: '')
  final String orderNo;
  @JsonKey(name: "orderState", defaultValue: 0)
  final int orderState;
  @JsonKey(name: "dscription", defaultValue: '')
  final String description;
  @JsonKey(name: "recipientAddress", defaultValue: '')
  final String recipientAddress;
  @JsonKey(name: "countOfItems", defaultValue: 0)
  final int countOfItems;
  @JsonKey(name: "senderPhoneNo", defaultValue: '')
  final String senderPhoneNo;
  @JsonKey(name: "createdAt", defaultValue: '')
  final String createdAt;
  @JsonKey(name: "updatedAt", defaultValue: '')
  final String updatedAt;
  @JsonKey(name: "recipientPhoneNo", defaultValue: '')
  final String recipientPhoneNo;
  @JsonKey(name: "price", defaultValue: 0)
  final double price;
  @JsonKey(name: "orderPrice", defaultValue: 0)
  final double orderPrice;
  @JsonKey(
    name: "representative",
  )
  final Representative? representative;

  OrderModel(
      this.orderId,
      this.orderNo,
      this.orderState,
      this.description,
      this.recipientAddress,
      this.countOfItems,
      this.senderPhoneNo,
      this.recipientPhoneNo,
      this.price,
      this.orderPrice,
      this.representative,
      this.createdAt,
      this.updatedAt);

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class Representative {
  @JsonKey(name: "name", defaultValue: '')
  final String name;
  @JsonKey(name: "phoneNumber", defaultValue: '')
  final String phoneNumber;

  Representative(this.name, this.phoneNumber);

  factory Representative.fromJson(Map<String, dynamic> json) =>
      _$RepresentativeFromJson(json);
  Map<String, dynamic> toJson() => _$RepresentativeToJson(this);
}
