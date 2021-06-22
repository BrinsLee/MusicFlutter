import 'package:flutter/material.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';
import 'package:music_flutter/common/models/album/newest_album_result.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/common/models/music/music_url.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/model/baseModel.dart';

class BannerViewModel extends BaseModel {
  BannerResult _bannerResult;

  BannerResult get bannerResult => _bannerResult;

  set bannerResult(BannerResult value) {
    _bannerResult = value;
    notifyListeners();
  }

  BannerViewModel(Api api) : super(api);

  Future<void> loadBanner(
      {@required BuildContext context,
      BannerRequest request,
      bool refresh = false,
      bool cacheDisk = true}) async {
    setState(ViewState.busyState);
    _bannerResult = await (api as BannerApi).getBanner(
        context: context,
        type: request,
        refresh: refresh,
        cacheDisk: cacheDisk);
    setState(ViewState.dataFetchState);
  }
}

class PersonalizedMusicViewModel extends BaseModel {
  PersonalizedMusicListResult _listResult;
  PersonalizedNewMusicResult _musicResult;

  PersonalizedMusicListResult get listResult => _listResult;

  set listResult(PersonalizedMusicListResult value) {
    _listResult = value;
    notifyListeners();
  }

  PersonalizedNewMusicResult get musicResult => _musicResult;

  set musicResult(PersonalizedNewMusicResult value) {
    _musicResult = value;
    notifyListeners();
  }

  PersonalizedMusicViewModel(Api api) : super(api);

  Future<void> loadPersonalizedNewMusic(
      {int limit = 10,
      @required BuildContext context,
      bool refresh = false,
      bool cacheDisk = false}) async {
    setState(ViewState.busyState);
    _musicResult = await (api as PersonalizedApi).getPersonalizedNewMusic(
        limit: limit, context: context, refresh: refresh, cacheDisk: cacheDisk);
    setState(ViewState.dataFetchState);
  }

  Future<void> loadPersonalizedMusicList(
      {int limit = 10,
      @required BuildContext context,
      bool refresh = false,
      bool cacheDisk = false}) async {
    setState(ViewState.busyState);
    _listResult = await (api as PersonalizedApi).getPersonalizedMusicList(
        limit: limit, context: context, refresh: refresh, cacheDisk: cacheDisk);
    setState(ViewState.dataFetchState);
  }

  Future<MusicUrl> loadMusicUrl(String id, {@required BuildContext context}) {
    return (api as PersonalizedApi).getMusicUrl(id, context: context);
  }
}

class NewestAlbumViewModel extends BaseModel {
  NewestAlbumResult _newestAlbum;

  NewestAlbumResult get newestAlbum => _newestAlbum;

  set newestAlbum(NewestAlbumResult value) {
    _newestAlbum = value;
    notifyListeners();
  }

  Future<void> loadNewestAlbum(
      {@required BuildContext context,
      bool refresh = false,
      bool cacheDisk = false}) async {
    setState(ViewState.busyState);
    _newestAlbum = await (api as NewestApi).getNewestAlbum(
        context: context, refresh: refresh, cacheDisk: cacheDisk);
    setState(ViewState.dataFetchState);
  }

  NewestAlbumViewModel(Api api) : super(api);
}
