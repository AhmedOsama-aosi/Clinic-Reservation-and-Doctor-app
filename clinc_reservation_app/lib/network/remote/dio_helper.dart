import 'package:dio/dio.dart';

import '../end_points.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    try {
      dio = Dio(
        BaseOptions(
            // baseUrl: 'https://apex.oracle.com/pls/apex/kadi1/',
            //baseUrl: 'http://192.168.1.40:3000/',
            baseUrl: BASEURL,
            receiveDataWhenStatusError: true,
            headers: {"Content-Type": "application/json"}),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Response> getdata({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(url,
        queryParameters: query, options: Options(headers: headers));
  }

  static Future<Response> postdata(
      {required String url,
      required Map<String, dynamic> posteddata,
      headers}) async {
    return await dio.post(url,
        data: posteddata, options: Options(headers: headers));
  }

  static Future<Response> patchdata(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> posteddata,
      headers}) async {
    return await dio.patch(url,
        queryParameters: query,
        data: posteddata,
        options: Options(headers: headers));
  }

  static Future<Response> deletedata({required String url}) async {
    return await dio.delete(url);
  }
}
