// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchContent _$BranchContentFromJson(Map<String, dynamic> json) =>
    BranchContent(
      branches: (json['content'] as List<dynamic>?)
              ?.map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BranchContentToJson(BranchContent instance) =>
    <String, dynamic>{
      'content': instance.branches,
    };

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      branchId: json['branchId'] as String? ?? '',
      branchName: json['branchName'] as String? ?? '',
      isMajor: json['isMajor'] as bool? ?? false,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'branchName': instance.branchName,
      'isMajor': instance.isMajor,
    };
