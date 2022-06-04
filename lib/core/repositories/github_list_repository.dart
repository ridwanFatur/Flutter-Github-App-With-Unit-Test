import 'package:project_documentation/core/entities/github_repo_entity.dart';

import 'package:tuple/tuple.dart';

abstract class GithubListRepository{
  Future<Tuple2<List<GithubRepoEntity>, int>> getData({required Map<String,dynamic> param});
}