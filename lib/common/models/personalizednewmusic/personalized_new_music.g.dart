// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalized_new_music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizedNewMusic _$PersonalizedNewMusicFromJson(Map<String, dynamic> json) {
  return PersonalizedNewMusic()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..duration = json['duration'] as int
    ..cover = json['cover'] as String
    ..picUrl = json['picUrl'] as String
    ..musicUrl = json['musicUrl'] as String
    ..type = json['type'] as int
    ..canDislike = json['canDislike'] as bool
    ..song = Song.fromJson(json['song'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PersonalizedNewMusicToJson(
        PersonalizedNewMusic instance) =>
    <String, dynamic>{
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
