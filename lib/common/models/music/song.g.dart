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
      NewestAlbum.fromJson(json['album'] as Map<String, dynamic>),
      (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['duration'] as int,
  );
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'position': instance.position,
      'alias': instance.alias,
      'status': instance.status,
      'album': instance.album,
      'artists': instance.artists,
      'duration': instance.duration,
    };
