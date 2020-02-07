import 'package:flutter/material.dart';
import 'package:flutter_app_01_github/model/github_model.dart';
import 'package:flutter_app_01_github/repository/github_api_client.dart';
import 'package:flutter_app_01_github/repository/github_repository.dart';
import 'package:flutter_app_01_github/widget/github_list.dart';
import 'package:flutter_app_01_github/widget/search_box.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GitHub Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => Page(),
            ),
            ChangeNotifierProvider(
              create: (context) => GitHubItems(),
            )
          ],
          child: _MyHomePage(),
        ));
  }
}

class _MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listView = GitHubList();
    var container = Container(
      child: Column(
        children: <Widget>[
          const SearchBox(),
          Expanded(
            child: listView,
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHubAPI"),
      ),
      body: container,
    );
  }
}

class GitHubItems extends ValueNotifier<GitHubListModel> {
  var loadFlag = false;
  var query = "";

  GitHubItems() : super(GitHubListModel());

  final GitHubRepository gitHubRepository = GitHubRepository(
    gitHubAPI: GitHubAPI(
      httpClient: http.Client(),
    ),
  );

  void getGitHubItems(String query) async {
    loadFlag = true;
    gitHubRepository.getItems(query, 1).then((onValue) {
      loadFlag = false;
      this.query = query;
      value = onValue;
    });
  }

  void addGitHubItems(int page) async {
    loadFlag = true;
    gitHubRepository.getItems(query, page).then((onValue) {
      loadFlag = false;
      value.inCompleteResults = onValue.inCompleteResults;
      value.totalCount = onValue.totalCount;
      for(var item in onValue.list) {
        value.list.add(item);
      }
      this.notifyListeners();
    });
  }

  bool isLoading() {
    return loadFlag;
  }
}

class Page extends ValueNotifier<int> {
  Page() : super(1);

  void increment() => value++;

  void reset() => value = 1;
}
