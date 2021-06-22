part of 'music_url.dart';

MusicUrl _$MusicUrlFromJson(Map<String, dynamic> json) {
  return MusicUrl(
    (json['data'] as List<dynamic>)
        .map((e) => MusicUrlData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MusicUrlToJson(MusicUrl instance) => <String, dynamic>{
      'data': instance.data,
    };
