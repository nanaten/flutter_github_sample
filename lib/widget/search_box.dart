import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_01_github/main.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBoxState();
  }

}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Flutter',
                labelText: 'Query',
              ),
              maxLines: 1,
              controller: _controller,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              child: const Text('Search'),
              onPressed: () {
                Provider.of<Page>(context).reset();
                Provider.of<GitHubItems>(context).getGitHubItems(_controller.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}