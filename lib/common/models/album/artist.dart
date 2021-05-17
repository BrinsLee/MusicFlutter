
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {

  String name;

  String id;

  String picId;

  String img1v1Id;

  String picUrl;

  String img1v1Url;

  int albumSize;

  List<String> alias;

  int musicSize;

  Artist(this.name, this.id, this.picId, this.img1v1Id, this.picUrl,
      this.img1v1Url, this.albumSize, this.alias, this.musicSize);

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}