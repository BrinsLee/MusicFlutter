part of 'music_url_data.dart';

MusicUrlData _$MusicUrlDataFromJson(Map<String, dynamic> json) {
  return MusicUrlData(json['url'] as String, json['id'] as int,
      json['size'] as int, json['type'] as String);
}

Map<String, dynamic> _$MusicUrlDataToJson(MusicUrlData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'size': instance.size,
    };
