import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';

part 'newest_album_result.g.dart';

@JsonSerializable()
class NewestAlbumResult {



  int code;
  List<NewestAlbum> albums;

  NewestAlbumResult(this.code, this.albums);

  factory NewestAlbumResult.fromJson(Map<String, dynamic> json) => _$NewestAlbumResultFromJson(json);

  Map<String, dynamic> toJson() => _$NewestAlbumResultToJson(this);
}
