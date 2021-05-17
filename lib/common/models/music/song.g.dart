// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song(
    json['alias'] as List<dynamic>,
    json['id'] as int,
    json['name'] as String,
    json['position'] as int,
    json['status'] as int,
  );
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'position': instance.position,
      'alias': instance.alias,
      'status': instance.status,
    };
