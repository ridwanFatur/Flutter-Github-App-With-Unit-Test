import 'package:flutter/material.dart';
import 'package:project_documentation/core/entities/github_repo_entity.dart';
import 'package:project_documentation/core/helpers/asset_constants.dart';

class ErrorLayout extends StatelessWidget {
  final String message;
  final VoidCallback onPress;
  const ErrorLayout({
    Key? key,
    required this.message,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPress,
              child: const Text("Reload"),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}

class NoDataLayout extends StatelessWidget {
  const NoDataLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 250,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetConstant.kIconNotFound,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              "Empy Data",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadingPaginationLayout extends StatelessWidget {
  const LoadingPaginationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class DataListLayout extends StatelessWidget {
  final List<GithubRepoEntity> githubList;
  final VoidCallback onPressItem;
  final Widget bottomWidget;
  final VoidCallback onScrollEnd;
  const DataListLayout({
    Key? key,
    required this.githubList,
    required this.onPressItem,
    required this.bottomWidget,
    required this.onScrollEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          final maxScroll = scrollNotification.metrics.maxScrollExtent;
          final currentScroll = scrollNotification.metrics.pixels;
          if (currentScroll == maxScroll) {
            onScrollEnd();
            return true;
          }
        }
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              githubList.length,
              (index) {
                GithubRepoEntity entity = githubList[index];
                return ItemGithubRepoEntity(
                  entity: entity,
                  onPressItem: onPressItem,
                );
              },
            ),
            bottomWidget,
          ],
        ),
      ),
    );
  }
}

class ItemGithubRepoEntity extends StatelessWidget {
  final GithubRepoEntity entity;
  final VoidCallback onPressItem;
  const ItemGithubRepoEntity({
    Key? key,
    required this.entity,
    required this.onPressItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressItem,
          splashFactory: InkRipple.splashFactory,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  entity.avatarUrl,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
