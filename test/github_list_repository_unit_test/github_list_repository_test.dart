import 'package:flutter_test/flutter_test.dart';
import 'package:project_documentation/core/entities/github_repo_entity.dart';
import 'package:project_documentation/core/repositories/github_list_repository_impl.dart';
import 'github_list_provider_mock.dart';
import 'package:tuple/tuple.dart';

void main() {
  test("Github Repository Success", () async {
    GithubListRepositoryImpl repository = GithubListRepositoryImpl(GithubListProviderMockSuccess());
    bool? isError;
    List<GithubRepoEntity> list = [];
    int totalCount = 0;

    try{
      Tuple2<List<GithubRepoEntity>, int> tuple = await repository.getData(param: {});
      list = tuple.item1;
      totalCount = tuple.item2;
      isError = false;
    }catch(e){
      isError = true;
    }

    expect(isError, false);
    expect(totalCount, 1);
    expect(list.length, 1);
  });

  test("Github Repository Failed", () async {
    GithubListRepositoryImpl repository = GithubListRepositoryImpl(GithubListProviderMockFailed());
    bool? isError;

    try{
      await repository.getData(param: {});
      isError = false;
    }catch(e){
      isError = true;
    }

    expect(isError, true);
  });
}