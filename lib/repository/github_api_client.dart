import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_01_github/model/github_model.dart';
import 'package:http/http.dart' as http;

class GitHubAPI {
  static const baseUrl = 'https://api.github.com';
  final http.Client httpClient;

  GitHubAPI({@required this.httpClient}): assert(httpClient != null);

  Future<GitHubListModel> getGitHubInfo(String query, int page) async {
    String url = '$baseUrl/search/repositories?sort=stars&q=$query&page=$page';

    var response = await httpClient.get(url);

    if (response.statusCode != 200) {
      return null;
    }
    var json = await jsonDecode(response.body);
    return GitHubListModel.fromJson(json);
  }
}