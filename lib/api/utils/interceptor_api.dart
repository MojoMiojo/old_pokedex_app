import 'dart:async';

import 'package:dio/dio.dart';

class InterceptorApi extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    print('AppInterceptor onRequest');
    Map<String, dynamic> header = {};

    header.addAll(options.headers);

    // if (options.extra['ignoreInterceptor'] == false) {
    //   if (frwkAuth.isAutenticado == true) {
    //     var token = frwkAuth.oAuthDTO.accessToken;
    //     if (token != null) header['Authorization'] = 'Bearer $token';
    //   }

    //   options.headers.addAll(header);
    // }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    return super.onError(err);
  }
}
