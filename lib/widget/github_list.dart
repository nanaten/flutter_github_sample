import 'package:flutter/cupertino.dart';
import 'package:flutter_app_01_github/main.dart';
import 'package:provider/provider.dart';
import 'search_box.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GitHubListState();
  }
}

class GitHubListState extends State<GitHubList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  var _listViewKey = Key('ListView');

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _items = Provider.of<GitHubItems>(context).value;
    int page = Provider.of<Page>(context).value;

    return ListView.builder(
        key: _listViewKey,
        controller: _scrollController,
        itemCount: _items?.hasMore(page) == true
            ? _items.list.length + 1
            : _items.list.length,
        itemBuilder: (BuildContext context, int index) {
          return index >= _items.list.length
              ? const BottomLoader()
              : GitHubListTile(
                  index: index,
                );
        },
      );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      var _items = Provider.of<GitHubItems>(context);
      if (!(_items?.isLoading() ?? false)) {
        var _page = Provider.of<Page>(context);
        if (_items?.value?.hasMore(_page.value) == true) {
          _page.increment();
          _items.addGitHubItems(_page.value);
        }
      }
    }
  }
}

class GitHubListTile extends StatelessWidget {
  final int index;

  GitHubListTile({this.index});

  @override
  Widget build(BuildContext context) {
    var _items = Provider.of<GitHubItems>(context).value;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_items.list[index].owner.avatarUrl),
      ),
      title: Text(
          '${_items.list[index].name} / ⭐ ${_items.list[index].stargazersCount}'),
      subtitle: Text(
          '${_items.list[index].language} / forks:${_items.list[index].forksCount}'),
      onTap: () {
        String url = _items.list[index].htmlUrl;
        _launchURL(url);
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
