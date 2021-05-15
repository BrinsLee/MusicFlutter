import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/entities.dart';


/// Created by lipeilin
/// on 2020/12/23

part 'personalized_new_music.g.dart';

@JsonSerializable()
class PersonalizedNewMusic extends BaseMusic {
  PersonalizedNewMusic() : super(false, '', 0, 0, '', '', '', null, 0);

  factory PersonalizedNewMusic.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedNewMusicFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedNewMusicToJson(this);
}
