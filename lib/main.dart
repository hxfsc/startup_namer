import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello World',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.white,
      ),
      home: new RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
          title: new Text("列表"),
        actions: [
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }




  final _suggestions = <WordPair>[];
  final _biggerFront = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();


  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder:(context){
            final tiles = _saved.map((pair){
              return new ListTile(
                  title: new Text(pair.asCamelCase, style: _biggerFront),
              );
            });

            final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

            return new Scaffold(
              appBar: new AppBar(title: new Text("Save Suggestions")),
              body: new ListView(children: divided),
            );
          }
      )
    );
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if(i.isOdd){
          return new Divider();
        }
        final index =  i ~/ 2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){

    final alreadSaved = _saved.contains(pair);
    return ListTile(
      title: new Text(pair.asCamelCase, style: _biggerFront),
      trailing: new Icon(
        alreadSaved ? Icons.favorite : Icons.favorite_border,
        color: alreadSaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadSaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}