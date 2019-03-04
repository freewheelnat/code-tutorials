import 'package:complexgestures/edit_controls_view.dart';
import 'package:complexgestures/image_edit_state_bloc.dart';
import 'package:complexgestures/photo_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex Gestures Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Complex Gestures'),
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

  bool _editInProgress = false;

  BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();

    ImageEditStateBloc().editStateData.listen((editStateData) {
      _editInProgress = editStateData.isInProgress();
      if (editStateData.isCanceled()) {
        _showCanceledMessage();
      } else if (editStateData.isCompleted()) {
        _showCompletedMessage(editStateData.value);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(
        child: Listener(
          onPointerMove: (pointerMoveEvent) {
            if (_editInProgress) {
              ImageEditStateBloc().editInProgress(MediaQuery.of(context).size.height - pointerMoveEvent.position.dy);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: PhotoView()),
              EditControlsView(),
            ],
          ),
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Builder(
          builder: (BuildContext context) {
            _scaffoldContext = context;
            return body;
          }
      ),
    );
  }

  void _showCanceledMessage() {
    Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
      content: new Text('Edit cancelled'),
      duration: new Duration(seconds: 2),
    ));
  }

  void _showCompletedMessage(double value) {
    Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
      content: new Text('Edit completed ' + value.toString()),
      duration: new Duration(seconds: 2),
    ));
  }

  @override
  void dispose() {
    ImageEditStateBloc().dispose();
    super.dispose();
  }
}
