// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newest_album_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewestAlbumResult _$NewestAlbumResultFromJson(Map<String, dynamic> json) {
  return NewestAlbumResult(
    json['code'] as int,
    (json['albums'] as List<dynamic>)
        .map((e) => NewestAlbum.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NewestAlbumResultToJson(NewestAlbumResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'albums': instance.albums,
    };
