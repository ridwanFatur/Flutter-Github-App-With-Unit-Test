import 'package:project_documentation/core/network_providers/github_list_provider.dart';

class GithubListProviderMockSuccess extends GithubListProvider{
  @override
  Future<Map<String, dynamic>> loadPage({required String url, required Map<String, dynamic> param}) async {
    return {
      "total_count": 1,
      "items": [
        {
          "id": 1,
          "full_name": "User-1",
          "owner": {
            "avatar_url": "URL-1"
          }
        }
      ],
    };
  }

}

class GithubListProviderMockFailed extends GithubListProvider{
  @override
  Future<Map<String, dynamic>> loadPage({required String url, required Map<String, dynamic> param}) async {
    return {
      "error": "Error Testing",
    };
  }

}