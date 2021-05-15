import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/common/widgets/toast.dart';
import 'package:music_flutter/global.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  static const BASE_URL = 'http://118.31.65.24/';

  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 10000,
        receiveTimeout: 5000,
        headers: {
          HttpHeaders.acceptHeader:
              "application/vnd.github.squirrel-girl-preview,"
                  "application/vnd.github.symmetra-preview+json",
        },
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json);

    dio = new Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // print("请求之前");
        // Loading.before(options.uri, '正在通讯...');
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        // print("响应之前");
        // Loading.complete(response.request.uri);
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        // print("错误之前");
        // Loading.complete(e.request.uri);
        ErrorEntity eInfo = createErrorEntity(e); //continue
        toastInfo(msg: eInfo.message ?? "");
        // 错误交互处理
        var context = e.requestOptions.extra["context"];
        if (context != null) {
          switch (eInfo.code) {
            case 401: // 没有权限 重新登录
              // goLoginPage(context);
              break;
            default:
          }
        }
        return handler.next(e);
      },
    ));
    // 加内存缓存
    dio.interceptors.add(NetCache());
  }

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
      case DioErrorType.response:
        {
          try {
            int errCode = error.response?.statusCode ?? 404;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(code: errCode, message: "请求语法错误");
                }
              case 401:
                {
                  return ErrorEntity(code: errCode, message: "没有权限");
                }
              case 403:
                {
                  return ErrorEntity(code: errCode, message: "服务器拒绝执行");
                }
              case 404:
                {
                  return ErrorEntity(code: errCode, message: "无法连接服务器");
                }
              case 405:
                {
                  return ErrorEntity(code: errCode, message: "请求方法被禁止");
                }
              case 500:
                {
                  return ErrorEntity(code: errCode, message: "服务器内部错误");
                }
              case 502:
                {
                  return ErrorEntity(code: errCode, message: "无效的请求");
                }
              case 503:
                {
                  return ErrorEntity(code: errCode, message: "服务器挂了");
                }
              case 505:
                {
                  return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
                }
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                      code: errCode, message: error.response?.statusMessage);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  Future get(
    String path, {
    required BuildContext context,
    dynamic params,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions = requestOptions.copyWith(extra: {
        "context": context,
        "refresh": refresh,
        "noCache": noCache,
        "list": list,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      });

      var response = await dio.get(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  Future post(
    String path, {
    required BuildContext context,
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
/*    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }*/
    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    /*Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }*/
    var response = await dio.put(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  Future patch(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code;
  String? message;

  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
