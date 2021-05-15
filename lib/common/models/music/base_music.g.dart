// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseMusic _$BaseMusicFromJson(Map<String, dynamic> json) {
  return BaseMusic(
    json['canDislike'] as bool,
    json['cover'] as String,
    json['duration'] as int,
    json['id'] as int,
    json['musicUrl'] as String,
    json['name'] as String,
    json['picUrl'] as String,
    json['song'] == null
        ? null
        : Song.fromJson(json['song'] as Map<String, dynamic>),
    json['type'] as int,
  );
}

Map<String, dynamic> _$BaseMusicToJson(BaseMusic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duration': instance.duration,
      'cover': instance.cover,
      'picUrl': instance.picUrl,
      'musicUrl': instance.musicUrl,
      'type': instance.type,
      'canDislike': instance.canDislike,
      'song': instance.song,
    };
