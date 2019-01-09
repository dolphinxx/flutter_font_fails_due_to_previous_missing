import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() async {
//  FontLoader fontLoader = FontLoader('我逸清晨体2');
//  fontLoader.addFont(rootBundle.load('assets/WoYiQingChenTi.ttf'));
//  await fontLoader.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dynamic Load Font'),
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
  final String article = '''
青青子衿，悠悠我心。
''';

  bool loaded = false;

  Future<void> loadFont() async {
    FontLoader fontLoader = FontLoader('我逸清晨体');
    fontLoader.addFont(rootBundle.load('assets/WoYiQingChenTi.ttf'));
    await fontLoader.load();
    fontLoader = FontLoader('我逸清晨体1');
    fontLoader.addFont(rootBundle.load('assets/WoYiQingChenTi.ttf'));
    await fontLoader.load();
    loaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadFont();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Demo('Raw', article, null),
          Demo('Missing font', article, '我逸清晨体',),
          Demo('Failed due to previous missing', article, loaded?'我逸清晨体':null,),
          Demo('Success', article, loaded?'我逸清晨体1':null,),
        ],
      ),
    );
  }
}

class Demo extends StatelessWidget {
  final String label;
  final String text;
  final String family;

  Demo(this.label, this.text, this.family);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(label, style: Theme.of(context).textTheme.title,),
          ),
          Text(text, style: TextStyle(fontFamily: family),)
        ],
      ),
    );
  }
}
