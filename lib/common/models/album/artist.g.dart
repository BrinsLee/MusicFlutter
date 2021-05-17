// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist(
    json['name'] as String,
    json['id'] as String,
    json['picId'] as String,
    json['img1v1Id'] as String,
    json['picUrl'] as String,
    json['img1v1Url'] as String,
    json['albumSize'] as int,
    (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
    json['musicSize'] as int,
  );
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'picId': instance.picId,
      'img1v1Id': instance.img1v1Id,
      'picUrl': instance.picUrl,
      'img1v1Url': instance.img1v1Url,
      'albumSize': instance.albumSize,
      'alias': instance.alias,
      'musicSize': instance.musicSize,
    };
