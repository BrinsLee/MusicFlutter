import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/global.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();

  void delete(String key) {
    cache.remove(key);
  }

  Future<void> _saveCache(Response object) async {
    RequestOptions options = object.requestOptions;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      if (options.extra["cacheDisk"] == true) {
        await StorageUtil().setJSON(key, object.data);
      }
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    if (!CACHE_ENABLE) {
      super.onRequest(options, handler);
      return;
    }

    bool refresh = options.extra["refresh"];
    bool cacheDisk = options.extra["cacheDisk"];

    if (refresh) {
      if (options.extra["list"]) {
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        delete(options.uri.toString());
      }

      if (cacheDisk) {
        await StorageUtil().remove(options.uri.toString());
      }
      super.onRequest(options, handler);
      return;
    }

    // get 请求，开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            CACHE_MAXAGE) {
          return handler.resolve(ob.response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = StorageUtil().getJSON(key);
        if (cacheData != null) {
          return handler.resolve(Response(
            requestOptions: options,
            statusCode: 200,
            data: cacheData,
          ));
        }
      }
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (CACHE_ENABLE) {
      await _saveCache(response);
    }
    super.onResponse(response, handler);
  }
}
