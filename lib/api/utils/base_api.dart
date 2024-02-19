import 'network_api.dart';

class BaseApi {
  final _frwkNetwork = NetworkApi.instance;

  Future<dynamic> request(
    HttpMethod method,
    String endpoint, {
    Map headers,
    body,
    bool cacheFirst = false,
    bool ignoreInterceptor = false,
  }) {
    return _frwkNetwork
        .request(method, endpoint,
            headers: headers, body: body, ignoreInterceptor: ignoreInterceptor)
        .then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> customGet(
    String url, {
    Map headers,
  }) async {
    return _frwkNetwork.customGet(url, headers: headers);
  }

  Future<dynamic> customPost(
    String url, {
    Map body,
    Map headers,
  }) async {
    return _frwkNetwork.customPost(url, body: body, headers: headers);
  }

  // Future<dynamic> multipartFile({
  //   @required String url,
  //   @required File file,
  //   Map headers,
  // }) async {
  //   return _frwkNetwork.multipartFile(
  //     url: url,
  //     file: file,
  //     headers: headers,
  //   );
  // }

}
