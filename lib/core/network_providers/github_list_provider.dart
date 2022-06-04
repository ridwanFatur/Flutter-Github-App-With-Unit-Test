abstract class GithubListProvider{
  Future<Map<String,dynamic>> loadPage({required String url, required Map<String,dynamic> param});
}