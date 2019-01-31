import 'package:flutter/material.dart';
import 'package:marvel_characters/api.dart';
import 'package:marvel_characters/model/character.dart';

void main() => runApp(MarvelCharactersApp());

class MarvelCharactersApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Characters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Marvel Characters'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Characters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('Use the search bar above!'),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  static const _suggestions = <String>[
    'spider',
    'thor',
    'hulk',
    'iron',
    'captain',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder<List<Character>>(
        future: Api().getCharacters(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(snapshot.data[index].name),
                    onTap: () {
                      query = snapshot.data[index].name;
                      showResults(context);
                    });
              },
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
        children: _suggestions
            .map((character) => ListTile(
                title: Text(character),
                onTap: () {
                  query = character;
                  showResults(context);
                }))
            .toList());
  }
}
