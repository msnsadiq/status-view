import 'dart:convert';

import 'package:http/http.dart';
import 'package:status_app/model/ModelClassStatus.dart';
import 'package:status_app/repository/api_client.dart';

class ApiStatus {
  ApiClient apiClient = ApiClient();
  final String basePath = "shakeebM/StoriesApi/stories";
  Future<List<ModelClassStatus>> getStatus() async {
    Response response =
        await apiClient.invokeAPI(path: basePath, method: 'GET', body: null);
    return ModelClassStatus.listFromJson(json.decode(response.body));
  }
}
