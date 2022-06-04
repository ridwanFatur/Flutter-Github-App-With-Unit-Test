import 'dart:convert';
import 'package:project_documentation/core/helpers/api_helper.dart';
import 'package:project_documentation/core/network_providers/github_list_provider.dart';
import 'package:http/http.dart' as http;

class GithubListProviderImpl extends GithubListProvider{
  @override
  Future<Map<String, dynamic>> loadPage({required String url, required Map<String, dynamic> param}) async {
    http.Response response = await ApiHelper.get(url, param);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    }else{
      throw Exception("Error Code: ${response.statusCode}");
    }
  }

}