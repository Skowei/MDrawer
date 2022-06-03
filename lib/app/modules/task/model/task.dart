import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  @HiveType(typeId: 3, adapterName: 'TaskAdapter')
  const factory Task({
    @HiveField(0) String? id,
    @HiveField(1) String? name,
    @HiveField(2) String? description,
    @HiveField(3) @Default(false) bool isDone,
    @HiveField(4) @Default('#262626') String? color,
    @HiveField(5) String? tableId,
  }) = _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
