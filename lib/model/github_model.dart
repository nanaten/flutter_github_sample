class GitHubListModel {
  bool inCompleteResults;
  int totalCount;
  List<GitHubItemModel> list;

  GitHubListModel() {
    this.inCompleteResults = true;
    this.totalCount = 0;
    this.list = [];
  }

  static fromJson(dynamic json) {
    List<dynamic> itemList = json['items'];
    var list = GitHubListModel();
    list.inCompleteResults = json['incomplete_results'];
    list.totalCount = json['total_count'];
    list.list = itemList.map((item) {
      var repo = GitHubItemModel();
      Map<String, Object> owner = item['owner'];
      repo.name = item['name'];
      repo.fullName = item['full_name'];
      repo.stargazersCount = item['stargazers_count'];
      repo.watchersCount = item['watchers_count'];
      repo.forksCount = item['forks_count'];
      repo.language = item['language'];
      repo.htmlUrl = item['html_url'];
      repo.owner.avatarUrl = owner['avatar_url'];
      repo.owner.login = owner['login'];
      repo.owner.htmlUrl = owner['html_url'];
      return repo;
    }).toList();
    return list;
  }

  bool hasMore(int page) {
    return totalCount > 30 * page;
  }
}

class GitHubItemModel {
  String name;
  String fullName;
  Owner owner;
  int stargazersCount;
  int watchersCount;
  int forksCount;
  String language;
  String htmlUrl;

  GitHubItemModel() {
    this.owner = Owner();
  }

  static fromJson(dynamic json) {
    List<dynamic> itemList = json['items'];

    return itemList.map((item) {
      var repo = GitHubItemModel();
      Map<String, Object> owner = item['owner'];
      repo.name = item['name'];
      repo.fullName = item['full_name'];
      repo.stargazersCount = item['stargazers_count'];
      repo.watchersCount = item['watchers_count'];
      repo.forksCount = item['forks_count'];
      repo.language = item['language'];
      repo.htmlUrl = item['html_url'];
      repo.owner.avatarUrl = owner['avatar_url'];
      repo.owner.login = owner['login'];
      repo.owner.htmlUrl = owner['html_url'];
      return repo;
    }).toList();
  }
}

class Owner {
  String login;
  String avatarUrl;
  String htmlUrl;
}
