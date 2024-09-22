import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchContent {
  @JsonKey(name: 'content', defaultValue: [])
  final List<BranchModel> branches;

  BranchContent({required this.branches});

  factory BranchContent.fromJson(Map<String, dynamic> json) => _$BranchContentFromJson(json);
  Map<String, dynamic> toJson() => _$BranchContentToJson(this);
}

@JsonSerializable()
class BranchModel {
  @JsonKey(name: 'branchId', defaultValue: '')
  String branchId;
  @JsonKey(name: 'branchName', defaultValue: '')
  String branchName;
  @JsonKey(name: 'isMajor', defaultValue: false)
  bool isMajor;

  BranchModel({required this.branchId, required this.branchName, required this.isMajor});

  factory BranchModel.fromJson(Map<String, dynamic> json) => _$BranchModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
