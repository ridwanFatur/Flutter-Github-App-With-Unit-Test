import 'package:flutter/material.dart';
import 'package:project_documentation/core/entities/github_repo_entity.dart';
import 'package:project_documentation/core/enums/network_result.dart';
import 'package:project_documentation/core/repositories/github_list_repository.dart';
import 'package:tuple/tuple.dart';

class GithubRepoListModel extends ChangeNotifier {
  final GithubListRepository repository;
  GithubRepoListModel(this.repository);

  List<GithubRepoEntity> githubList = [];
  NetworkResult<List<GithubRepoEntity>> mainNetworkResult = ResultInit();
  NetworkResult<List<GithubRepoEntity>> paginationNetworkResult = ResultInit();
  int page = 1;
  int totalPage = 1;
  String query = defaultQuery;

  static const String defaultQuery = "test";

  Future<void> loadMain() async {
    setMainLoading();
    Map<String, dynamic> param = {
      "q": query,
      "page": 1,
    };

    try {
      Tuple2<List<GithubRepoEntity>, int> response =
          await repository.getData(param: param);
      List<GithubRepoEntity> list = response.item1;
      int totalCount = response.item2;
      setMainData(list, totalCount);
    } catch (e) {
      setMainError(e.toString());
    }
  }

  Future<void> loadPagination() async {
    setPaginationLoading();

    Map<String, dynamic> param = {
      "q": query,
      "page": page + 1,
    };

    try {
      Tuple2<List<GithubRepoEntity>, int> response =
          await repository.getData(param: param);
      List<GithubRepoEntity> list = response.item1;
      addPaginationData(list);
    } catch (e) {
      setPaginationError(e.toString());
    }
  }

  void changeQuery(String query) {
    this.query = query;
    if (query.isEmpty) {
      this.query = defaultQuery;
    }

    page = 1;
    totalPage = 1;
  }

  bool canLoadPagination() {
    return page < totalPage &&
        paginationNetworkResult is! ResultError &&
        paginationNetworkResult is! ResultLoading;
  }

  void setMainLoading() {
    mainNetworkResult = ResultLoading();
    githubList.clear();
    notifyListeners();
  }

  void setPaginationLoading() {
    paginationNetworkResult = ResultLoading();
     notifyListeners();
  }

  void setMainError(String message) {
    mainNetworkResult = ResultError(message);
     notifyListeners();
  }

  void setPaginationError(String message) {
    paginationNetworkResult = ResultError(message);
     notifyListeners();
  }

  void setMainData(List<GithubRepoEntity> list, int count) {
    mainNetworkResult = ResultSuccess(list);
    totalPage = (count / 30.0).ceil();
    _setList(list);
    notifyListeners();
  }

  void addPaginationData(List<GithubRepoEntity> list) {
    paginationNetworkResult = ResultSuccess(list);
    page += 1;
    print("TAG: Load $page");
    _addList(list);
     notifyListeners();
  }

  void _addList(List<GithubRepoEntity> list) {
    githubList.addAll(list);
  }

  void _setList(List<GithubRepoEntity> list) {
    githubList.clear();
    githubList.addAll(list);
  }
}
