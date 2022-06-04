import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_documentation/core/enums/network_result.dart';
import 'package:project_documentation/core/widgets/input_search_text_field.dart';
import 'package:project_documentation/features/github_repo_list/github_repo_list_model.dart';
import 'package:project_documentation/features/github_repo_list/layout/layout.dart';
import 'package:provider/provider.dart';

class GithubRepoListScreen extends StatefulWidget {
  const GithubRepoListScreen({Key? key}) : super(key: key);

  @override
  State<GithubRepoListScreen> createState() => _GithubRepoListScreenState();
}

class _GithubRepoListScreenState extends State<GithubRepoListScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(const Duration(seconds: 0));
    context.read<GithubRepoListModel>().loadMain();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InputSearchTextField(
                  controller: _searchTextController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) {
                      _debounce?.cancel();
                    }
            
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      context.read<GithubRepoListModel>().changeQuery(value);
                      context.read<GithubRepoListModel>().loadMain();
                    });
                  },
                  hintText: "Search",
                ),
              ),
            ),
            Expanded(
              child: Consumer<GithubRepoListModel>(
                builder: (context, model, _) {
                  if (model.mainNetworkResult is ResultError) {
                    return ErrorLayout(
                      message: model.mainNetworkResult.message!,
                      onPress: () {
                        context.read<GithubRepoListModel>().loadMain();
                      },
                    );
                  }

                  if (model.mainNetworkResult is ResultSuccess) {
                    if (model.githubList.isEmpty) {
                      return const NoDataLayout();
                    } else {
                      return DataListLayout(
                        githubList: model.githubList,
                        onPressItem: () {},
                        onScrollEnd: () {
                          if (model.canLoadPagination()) {
                            context
                                .read<GithubRepoListModel>()
                                .loadPagination();
                          }
                        },
                        bottomWidget: () {
                          if (model.paginationNetworkResult is ResultError) {
                            return ErrorLayout(
                              message: model.paginationNetworkResult.message!,
                              onPress: () {
                                context
                                    .read<GithubRepoListModel>()
                                    .loadPagination();
                              },
                            );
                          }

                          if (model.paginationNetworkResult is ResultLoading) {
                            return const LoadingPaginationLayout();
                          }

                          // Init
                          return const SizedBox();
                        }(),
                      );
                    }
                  }

                  // Loading
                  if (model.mainNetworkResult is ResultLoading) {
                    return const LoadingLayout();
                  }

                  // Init
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
