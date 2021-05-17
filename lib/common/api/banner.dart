import 'package:flutter/cupertino.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/global.dart';
import 'package:music_flutter/http/http.dart';


class BannerApi extends Api{
  /// 获取banner横幅广告
  Future<BannerResult> getBanner({
    @required BuildContext context,
    BannerRequest type,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var result = await HttpUtil().get(
      "/banner",
      context: context,
      params: type?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
      cacheKey: STORAGE_INDEX_BANNER_CACHE_KEY,
    );
    return BannerResult.fromJson(result);
  }
}
