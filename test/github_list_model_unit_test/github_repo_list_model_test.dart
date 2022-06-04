import 'package:flutter_test/flutter_test.dart';
import 'package:project_documentation/core/enums/network_result.dart';
import 'package:project_documentation/features/github_repo_list/github_repo_list_model.dart';
import 'github_list_repository_mock.dart';

void main() {
  test("Github Repo Model Test", () async {
    GithubRepoListModel model = GithubRepoListModel(GithubListRepositoryMock());

    // Load First, totalCount = 40, pageSize = 30, page = 1, page-1 = 30
    await model.loadMain();
    expect(model.mainNetworkResult is ResultSuccess, true);
    expect(model.mainNetworkResult.data != null, true);
    expect(model.githubList.length, 30);
    expect(model.totalPage, 2);

    // Load Pagination, totalCount = 40, pageSize = 10, page = 1, page-2 = 10
    expect(model.canLoadPagination(), true);
    await model.loadPagination();
    expect(model.paginationNetworkResult is ResultSuccess, true);
    expect(model.paginationNetworkResult.data != null, true);
    expect(model.githubList.length, 40);
    expect(model.page == 2, true);

    // // Change Query, query = "program", page = 1, pageSize = 30, totalCount = 14, page-1 = 14
    model.changeQuery("program");
    expect(model.page == 1, true);
    await model.loadMain();
    expect(model.githubList.length, 14);
    expect(model.totalPage == 1, true);
    expect(model.canLoadPagination(), false);

    // // Change Query, query = "error", result "Error" Exception
    model.changeQuery("error");
    expect(model.page == 1, true);
    await model.loadMain();
    expect(model.mainNetworkResult is ResultError, true);
    expect(model.mainNetworkResult.message == "Exception: Error", true);
    expect(model.canLoadPagination(), false);

    // [Again] Change Query, query = "program", page = 1, pageSize = 30, totalCount = 14, page-1 = 14
    model.changeQuery("program");
    expect(model.page == 1, true);
    await model.loadMain();
    expect(model.githubList.length == 14, true);
    expect(model.totalPage == 1, true);
    expect(model.canLoadPagination(), false);
  });
}
