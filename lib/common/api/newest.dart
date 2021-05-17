import 'package:flutter/cupertino.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';
import 'package:music_flutter/common/models/album/newest_album_result.dart';
import 'package:music_flutter/global.dart';
import 'package:music_flutter/http/http.dart';

class NewestApi extends Api {
  /// 最新专辑
  Future<NewestAlbumResult> getNewestAlbum(
      {@required BuildContext context,
      bool refresh = false,
      bool cacheDisk = false}) async {
    var result = await HttpUtil().get("/album/newest",
        context: context,
        refresh: refresh,
        cacheDisk: cacheDisk,
        cacheKey: STORAGE_NEWEST_ALBUM_CACHE_KEY);
    return NewestAlbumResult.fromJson(result);
  }
}
