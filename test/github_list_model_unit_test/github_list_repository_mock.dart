import 'package:project_documentation/core/entities/github_repo_entity.dart';
import 'package:project_documentation/core/repositories/github_list_repository.dart';
import 'package:project_documentation/features/github_repo_list/github_repo_list_model.dart';
import 'package:tuple/tuple.dart';

class GithubListRepositoryMock extends GithubListRepository {
  @override
  Future<Tuple2<List<GithubRepoEntity>, int>> getData(
      {required Map<String, dynamic> param}) {
    int page = param["page"];
    String query = param["q"];

    if (page == 1 && query == GithubRepoListModel.defaultQuery) {
      List<GithubRepoEntity> list = [];
      for (int i = 1; i <= 30; i++) {
        GithubRepoEntity entity = GithubRepoEntity(
          id: i,
          fullName: "Fullname $i",
          avatarUrl: "AvatarUrl $i",
        );
        list.add(entity);
      }
      return Future.value(Tuple2(list, 40));
    } else if (page == 2 && query == GithubRepoListModel.defaultQuery) {
      List<GithubRepoEntity> list = [];
      for (int i = 31; i <= 40; i++) {
        GithubRepoEntity entity = GithubRepoEntity(
          id: i,
          fullName: "Fullname $i",
          avatarUrl: "AvatarUrl $i",
        );
        list.add(entity);
      }
      return Future.value(Tuple2(list, 40));
    } else if (page == 1 && query == "program") {
      List<GithubRepoEntity> list = [];
      for (int i = 1; i <= 14; i++) {
        GithubRepoEntity entity = GithubRepoEntity(
          id: i,
          fullName: "Fullname $i",
          avatarUrl: "AvatarUrl $i",
        );
        list.add(entity);
      }
      return Future.value(Tuple2(list, 14));
    } else if (page == 1 && query == "error") {
      throw Exception("Error");
    } else {
      throw Exception("Error");
    }
  }
}
