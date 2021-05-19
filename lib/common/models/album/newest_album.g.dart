// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newest_album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewestAlbum _$NewestAlbumFromJson(Map<String, dynamic> json) {
  return NewestAlbum(
    json['name'] as String,
    json['id'] as int,
    json['type'] as String,
    json['size'] as int,
    json['picId'] as int,
    json['blurPicUrl'] as String,
    json['companyId'] as int,
    json['picUrl'] as String,
    json['publishTime'] as int,
    json['description'] as String,
    json['tags'] as String,
    json['company'] as String,
    Artist.fromJson(json['artist'] as Map<String, dynamic>),
    (json['artists'] as List<dynamic>)
        .map((e) => Artist.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NewestAlbumToJson(NewestAlbum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'type': instance.type,
      'size': instance.size,
      'picId': instance.picId,
      'blurPicUrl': instance.blurPicUrl,
      'companyId': instance.companyId,
      'picUrl': instance.picUrl,
      'publishTime': instance.publishTime,
      'description': instance.description,
      'tags': instance.tags,
      'company': instance.company,
      'artist': instance.artist,
      'artists': instance.artists,
    };
