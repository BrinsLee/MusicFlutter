
import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/music/music_url_data.dart';

part 'music_url.g.dart';

@JsonSerializable()
class MusicUrl {
  List<MusicUrlData> data;

  MusicUrl(this.data);

  factory MusicUrl.fromJson(Map<String, dynamic> json) =>
      _$MusicUrlFromJson(json);

  Map<String, dynamic> toJson() => _$MusicUrlToJson(this);
}