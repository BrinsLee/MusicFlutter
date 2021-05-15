import 'package:flutter/material.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/global.dart';
import 'package:music_flutter/http/http.dart';


class PersonalizedApi extends Api{
  /// 获取推荐音乐列表
  Future<PersonalizedMusicListResult> getPersonalizedMusicList({
    int limit = 10,
    required BuildContext context,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var result = await HttpUtil().get("/personalized",
        context: context,
        params: <String, dynamic>{
          'limit': limit,
        },
        refresh: refresh,
        cacheDisk: cacheDisk,
        cacheKey: STORAGE_PERSONALIZED_MUSIC_LIST_CACHE_KEY);
    return PersonalizedMusicListResult.fromJson(result);
  }

  /// 获取推荐新音乐
  Future<PersonalizedNewMusicResult> getPersonalizedNewMusic({
    int limit = 10,
    required BuildContext context,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var result = await HttpUtil().get(
      "/personalized/newsong",
      context: context,
      params: <String, dynamic>{
        'limit': limit,
      },
      refresh: refresh,
      cacheDisk: cacheDisk,
      cacheKey: STORAGE_PERSONALIZED_NEW_MUSIC_CACHE_KEY,
    );
    return PersonalizedNewMusicResult.fromJson(result);
  }
}
