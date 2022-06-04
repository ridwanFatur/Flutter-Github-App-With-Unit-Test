import 'package:project_documentation/core/entities/github_repo_entity.dart';
import 'package:project_documentation/core/network_providers/github_list_provider.dart';
import 'package:project_documentation/core/repositories/github_list_repository.dart';
import 'package:tuple/tuple.dart';

class GithubListRepositoryImpl extends GithubListRepository{
  final String url = "https://api.github.com/search/repositories";
  final GithubListProvider provider;

  GithubListRepositoryImpl(this.provider);

  @override
  Future<Tuple2<List<GithubRepoEntity>, int>> getData({required Map<String, dynamic> param}) async {
    Map<String, dynamic> map = await provider.loadPage(url: url, param: param);
    int totalCount = map["total_count"];
    List<dynamic> list = map["items"];
    List<GithubRepoEntity> githubList = list.map((e) {
      return GithubRepoEntity.fromMap(e);
    }).toList();

    return Tuple2(githubList, totalCount);
  }

}