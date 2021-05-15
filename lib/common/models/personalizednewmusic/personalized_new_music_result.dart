import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_flutter/common/models/entities.dart';

/// Created by lipeilin 
/// on 2020/12/21
part 'personalized_new_music_result.g.dart';

@JsonSerializable()
class PersonalizedNewMusicResult {

  int code = 0;
  int category = 0;

  List<PersonalizedNewMusic?>? result;

  PersonalizedNewMusicResult(this.code, this.category, this.result);

  factory PersonalizedNewMusicResult.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedNewMusicResultFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedNewMusicResultToJson(this);
}