// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<_$_Task> {
  @override
  final int typeId = 3;

  @override
  _$_Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Task(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      isDone: fields[3] as bool,
      color: fields[4] as String?,
      tableId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.tableId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isDone: json['isDone'] as bool? ?? false,
      color: json['color'] as String? ?? '#262626',
      tableId: json['tableId'] as String?,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isDone': instance.isDone,
      'color': instance.color,
      'tableId': instance.tableId,
    };
