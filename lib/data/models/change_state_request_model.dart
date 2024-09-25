import 'package:json_annotation/json_annotation.dart';

part 'change_state_request_model.g.dart';

@JsonSerializable()
class ChangeStateRequestRequest {
  String orderNo;
  int orderState;

  ChangeStateRequestRequest({
    required this.orderNo,
    required this.orderState,
  });

  factory ChangeStateRequestRequest.fromJson(Map<String, dynamic> json) => _$ChangeStateRequestRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeStateRequestRequestToJson(this);
}

