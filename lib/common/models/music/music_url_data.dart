import 'package:json_annotation/json_annotation.dart';

part 'music_url_data.g.dart';
@JsonSerializable()
class MusicUrlData {
    String url;

    int id;

    int size;

    String type;

    MusicUrlData(this.url, this.id, this.size, this.type);

    factory MusicUrlData.fromJson(Map<String, dynamic> json) =>
        _$MusicUrlDataFromJson(json);

    Map<String, dynamic> toJson() => _$MusicUrlDataToJson(this);
}