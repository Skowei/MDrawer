import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  @HiveType(typeId: 0, adapterName: 'ProjectAdapter')
  const factory Project({
    @HiveField(0) String? id,
    @HiveField(1) String? name,
    @HiveField(2) String? description,
    @HiveField(3) @Default('#262626') String? color,
    @HiveField(4) @Default('') String table,
  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
