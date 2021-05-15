// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalized_new_music_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizedNewMusicResult _$PersonalizedNewMusicResultFromJson(
    Map<String, dynamic> json) {
  return PersonalizedNewMusicResult(
    json['code'] as int,
    json['category'] as int,
    (json['result'] as List)
        .map((e) => e == null
            ? null
            : PersonalizedNewMusic.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PersonalizedNewMusicResultToJson(
        PersonalizedNewMusicResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'category': instance.category,
      'result': instance.result,
    };
