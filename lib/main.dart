import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_documentation/core/network_providers/github_list_provider_impl.dart';
import 'package:project_documentation/core/repositories/github_list_repository_impl.dart';
import 'package:project_documentation/features/github_repo_list/github_repo_list_model.dart';
import 'package:project_documentation/features/github_repo_list/github_repo_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => GithubRepoListModel(
                GithubListRepositoryImpl(GithubListProviderImpl())),
          ),
        ],
        child: const GithubRepoListScreen(),
      ),
    );
  }
}
