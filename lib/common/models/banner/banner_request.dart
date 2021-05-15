import 'package:json_annotation/json_annotation.dart';

part 'banner_request.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
// 自动生成指令 flutter packages pub run build_runner build
// 持续生成指令 flutter packages pub run build_runner watch
@JsonSerializable()
class BannerRequest {
  String type;

  BannerRequest(this.type);

  factory BannerRequest.fromJson(Map<String, dynamic> json) => _$BannerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BannerRequestToJson(this);
}