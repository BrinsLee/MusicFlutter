// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseMusic _$BaseMusicFromJson(Map<String, dynamic> json) {
  return BaseMusic(
      json['canDislike'] as bool,
      json['cover'] as String,
      json['duration']?? json['dt'] as int,
      json['id'] as int,
      json['musicUrl'] as String,
      json['name'] as String,
      json['picUrl'] as String,
      Song.fromJson(
          json['song'] ?? json['album'] ?? json['al'] as Map<String, dynamic>),
      json['type'] as int,
      (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList());
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
      'artists': instance.artists,
    };
