import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/album/artist.dart';

import 'song.dart';

/// Created by lipeilin
/// on 2020/12/23
part 'base_music.g.dart';

@JsonSerializable()
class BaseMusic {
  int id;

  String name;

  int duration;

  String cover;

  String picUrl;

  String musicUrl;

  int type;

  bool canDislike = true;

  Song song;

  List<Artist> artists;

  BaseMusic(this.canDislike, this.cover, this.duration, this.id, this.musicUrl,
      this.name, this.picUrl, this.song, this.type, this.artists);

  factory BaseMusic.fromJson(Map<String, dynamic> json) =>
      _$BaseMusicFromJson(json);

  Map<String, dynamic> toJson() => _$BaseMusicToJson(this);
}
