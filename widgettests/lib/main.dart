import 'package:flutter/material.dart';
import 'package:widgettests/details/details_bloc.dart';
import 'package:widgettests/list/list_bloc.dart';
import 'package:widgettests/list/list_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Tests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }


  @override
  void dispose() {
    ListBloc().dispose();
    DetailsBloc().dispose();
    super.dispose();
  }
}

