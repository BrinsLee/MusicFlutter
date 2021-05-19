import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/album/artist.dart';

part 'newest_album.g.dart';

@JsonSerializable()
class NewestAlbum {

  String name;

  int id;

  String type;

  int size;

  int picId;

  String blurPicUrl;

  int companyId;

  String picUrl;

  int publishTime;

  String description;

  String tags;

  String company;

  Artist artist;

  List<Artist> artists;

  NewestAlbum(
      this.name,
      this.id,
      this.type,
      this.size,
      this.picId,
      this.blurPicUrl,
      this.companyId,
      this.picUrl,
      this.publishTime,
      this.description,
      this.tags,
      this.company,
      this.artist,
      this.artists
      );

  factory NewestAlbum.fromJson(Map<String, dynamic> json) => _$NewestAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$NewestAlbumToJson(this);
}

