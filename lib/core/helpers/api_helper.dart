import 'package:http/http.dart' as http;

class ApiHelper{
  static Future<http.Response> get(
    String url,
    Map<String, dynamic> param,
  ) async {
    Uri uri = Uri.parse(url);
    param = param.map((key, value) {
      return MapEntry(key, value.toString());
    });
    final Uri newUri = uri.replace(queryParameters: param);
    final response = await http.get(newUri);
    return response;
  }
}