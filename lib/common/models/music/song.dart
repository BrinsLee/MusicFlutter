import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Song(this.alias,this.id,this.name,this.position,this.status);

  factory Song.fromJson(Map<String, dynamic> json) =>
      _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}