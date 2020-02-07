
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_01_github/model/github_model.dart';
import 'package:flutter_app_01_github/repository/github_api_client.dart';

class GitHubRepository {
  final GitHubAPI gitHubAPI;
  GitHubRepository({@required this.gitHubAPI}): assert(gitHubAPI != null);

  Future<GitHubListModel> getItems(String query, int page) async {
    return gitHubAPI.getGitHubInfo(query, page);
  }
}