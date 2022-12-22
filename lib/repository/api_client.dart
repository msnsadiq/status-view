import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:voyage/ApiSection/Repository/api_exception.dart';

import 'api_exception.dart';

class ApiClient {
  static final String basePath = 'http://my-json-server.typicode.com/';

  Future<Response> invokeAPI(
      {required String path,
      required String method,
      required Object? body}) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    // final token = prefs.getString('token');
    // print(prefs.getString('token'));
    // print(prefs.getString('token'));
    print("Invoke Api worked");
    print(method);

    Map<String, String> headerParams = {};
    if (method == 'POST' || method == 'GET' || method == 'PATCH') {
      print("Methode POST OR GET");
      headerParams = {
        //  "authorization": "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
    }
    Response response;

    String url = basePath + path;
    // String searchurl =  basePath + 'search/movie'+'?api_key=$token'+ path;
    print('========================================' + url);

    // print(searchurl);
    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "LOGIN":
        response =
            await post(Uri.parse(url), headers: headerParams, body: body);
        break;
      case "PUT":
        response = await put(Uri.parse(url), headers: headerParams, body: body);
        break;
      case "PATCH":
        response = await patch(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "DELETE":
        response = await delete(Uri.parse(url), headers: nullableHeaderParams);
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: headerParams,
          body: body,
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;

      default:
        response = await get(Uri.parse(url), headers: headerParams);
    }

    print('status of $path =>' + (response.statusCode).toString());
    print(response.body);
    if (response.statusCode >= 400) {
      // print("if)()");
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);

      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    ;
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}
