import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/album/artist.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';

/// Created by lipeilin 
/// on 2021/2/5
part 'song.g.dart';

@JsonSerializable()
class Song {
  String name;

  int id;

  int position;

  List<dynamic> alias;

  int status;

  NewestAlbum album;

  List<Artist> artists;

  int duration;

  Song(this.alias,this.id,this.name,this.position,this.status, this.album, this.artists, this.duration);



  factory Song.fromJson(Map<String, dynamic> json) =>
      _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}