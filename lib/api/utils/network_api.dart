import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'interceptor_api.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class NetworkApi {
  static Dio _dio;

  static BaseOptions _baseOptions = new BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/',
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  static final instance = NetworkApi._();

  NetworkApi._() {
    this._init();
    this._addInterceptor(InterceptorApi());
  }

  _init() {
    if (_dio == null) {
      _dio = Dio(_baseOptions);

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  _addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// ==========================================================
  /// Requests
  ///

  String textToMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  Future<dynamic> request(HttpMethod method, String endpoint,
      {Map headers, body, @required bool ignoreInterceptor}) async {
    dynamic response;

/*  var privateKey = 
    var publicKey = 
    var ts = DateTime.now().millisecondsSinceEpoch;
    var hash = this.textToMd5('$ts$privateKey$publicKey');
    endpoint = endpoint + '&apikey=$publicKey&hash=$hash&ts=$ts';
    print(endpoint); */

    try {
      if (method == HttpMethod.GET) {
        response = await this._get(endpoint,
            headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.POST) {
        response = await this._post(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PUT) {
        response = await this._put(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PATCH) {
        response = await this._patch(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.DELETE) {
        response = await this._delete(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else {
        printWrapped('HttpMethod desconhecido!');
      }
    } catch (e) {
      printWrapped(
          "Exception Request => ($method) => ${_dio.options.baseUrl}$endpoint");
      if (body != null)
        printWrapped('Exception Body => ${jsonEncode(body) ?? ''}');
      printWrapped('Exception Headers => ${e.request.headers}');
      printWrapped('Exception Response => ${e.response?.data}');
      printWrapped('Exception => ${e.toString()}');

      if (e is DioError) {
        var dioError = e;

        printWrapped('Exception Dio => ${dioError.message}');

        if (dioError.response.statusCode == 300) {
          // Multiple Choices
          return dioError.response.data['data'];
        }

        String message = dioError?.response?.data['data']['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    return response;
  }

  Future<dynamic> _get(String endpoint,
      {Map headers, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.get(
      endpoint,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _post(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.post(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _put(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.put(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _patch(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.patch(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _delete(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.delete(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  /// ==========================================================
  /// Custom
  ///

  Future<dynamic> customPost(String endpoint, {Map headers, body}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Map<String, dynamic> header = {};
    header.addAll(headers);

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};
    options.headers = header;

    dynamic response;

    try {
      response = await Dio(_baseOptions = new BaseOptions(
        connectTimeout: 60000,
        receiveTimeout: 60000,
      ))
          .post(
        endpoint,
        data: body,
        options: options,
      );
    } catch (e) {
      printWrapped("Exception Request => (POST) => $endpoint");
      if (body != null)
        printWrapped('Exception Body => ${jsonEncode(body) ?? ''}');
      printWrapped('Exception Headers => ${e.request.headers}');
      printWrapped('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        printWrapped('Exception Dio => ${dioError.message}');
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    printWrapped('Request Headers => ${response.request.headers}');
    printWrapped(
        "Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      printWrapped("${jsonEncode(response.request.data) ?? ''}");
    printWrapped(
        "Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response.data;
  }

  Future<dynamic> customGet(String endpoint, {Map headers}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};
    // options.headers = headers;

    dynamic response;
    try {
      response = await Dio().get(
        endpoint,
        options: options,
      );
    } catch (e) {
      printWrapped(e);
      printWrapped("Exception Request => (GET) => $endpoint");
      printWrapped('Exception Headers => ${e.request.headers}');
      printWrapped('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        printWrapped('Exception Dio => ${dioError.message}');
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    printWrapped('Request Headers => ${response.request.headers}');
    printWrapped(
        "Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      printWrapped("${jsonEncode(response.request.data) ?? ''}");
    printWrapped(
        "Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response.data;
  }

  dynamic _generateResponse(Response response) {
    if (response == null) {
      printWrapped('404 - Response null');
      throw new Exception(
          'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
    }

    final int statusCode = response.statusCode;

    printWrapped('Request Headers => ${response.request.headers}');
    printWrapped(
        "Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      printWrapped("${jsonEncode(response.request.data) ?? ''}");
    printWrapped("Response ($statusCode) => ${jsonEncode(response.data)}");

    final decoded = response.data;

    if (statusCode < 200 || statusCode > 204) {
      if (decoded != null && decoded["data"] != null) {
        throw new Exception(decoded["data"]);
      }
      throw new Exception(
          'Não foi poss��vel concluir sua chamada! Tente novamente mais tarde.');
    }
    if (decoded == null) return null;
    if (decoded is List) {
      return decoded;
    } else if (decoded is Map) {
      if (decoded["data"] != null) {
        return decoded["data"];
      } else if (decoded.isNotEmpty) {
        return decoded;
      } else {
        return null;
      }
    }
    if (decoded is String && decoded.isEmpty)
      return null;
    else {
      return decoded;
    }
  }

  Future<Options> _getCustomConfig(
      Map<String, String> customHeader, bool ignoreInterceptor) async {
    Options options = Options();
    options.extra = {'ignoreInterceptor': ignoreInterceptor};
    options.headers = await this._getDefaultHeader(customHeader);
    return options;
  }

  Future<Map<String, String>> _getDefaultHeader(
      Map<String, String> customHeader) async {
    Map<String, String> header = {"Content-Type": "application/json"};

    if (customHeader != null) {
      header.addAll(customHeader);
    }

    return header;
  }

  /// ==========================================================
  /// Extras

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  // Future<dynamic> multipartFile({
  //   @required String url,
  //   @required File file,
  //   Map headers,
  // }) async {
  //   if (!await this.isConnected()) {
  //     throw new Exception('Verifique sua conexão e tente novamente!');
  //   }

  //   printWrapped('lookupMimeType(file.path) -> ${lookupMimeType(file.path)}');
  //   printWrapped('path.extension(file.path) -> ${path.extension(file.path)}');

  //   var postUri = Uri.parse(url);

  //   var request = new http.MultipartRequest('POST', postUri);

  //   request.headers['Content-Type'] = 'application/x-www-form-urlencoded';

  //   // request.headers['Authorization'] = 'Bearer ${await frwkLogin.accessToken}';

  //   request.files.add(
  //     new http.MultipartFile.fromBytes(
  //       'file',
  //       await file.readAsBytes(),
  //       filename: path.basename(file.path),
  //       contentType: MediaType(
  //         lookupMimeType(file.path),
  //         path.extension(file.path),
  //       ),
  //     ),
  //   );

  //   return request.send().then((response) async {
  //     printWrapped("Request (MultipartFile): $url");
  //     printWrapped("Multipar Response Code: ${response.statusCode}");
  //     if (response.statusCode < 200 || response.statusCode > 204) {
  //       throw new Exception('Erro desconhecido!');
  //     } else {
  //       printWrapped("Uploaded!");
  //       var a = await response.stream.bytesToString();
  //       printWrapped("Response: $a");
  //       Map map = json.decodes(a);
  //       return map['data'];
  //     }
  //   });
  // }

  void printWrapped(String text) {
    print(text);
    // _logger.v(text);
    // log(text, name: 'ssa');
    // debugPrint(text, wrapWidth: 1024);
    // final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    // pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
