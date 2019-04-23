import 'package:flutter/material.dart';
import 'package:widgettests/details/details_bloc.dart';
import 'package:widgettests/list/list_bloc.dart';
import 'package:widgettests/list/model.dart';
import 'package:widgettests/strings.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  void initState() {
    super.initState();
    DetailsBloc().getItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<Item>(
            stream: DetailsBloc().outItem,
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Text(snapshot.data.title);
              }
            },
          ),
        ),

        body: StreamBuilder<Item>(
          stream: DetailsBloc().outItem,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _buildDetailsView(snapshot.data);
            }
          },
        ),
    );
  }

  Widget _buildDetailsView(Item item) {
    Widget button = item.selected? RaisedButton(
        child: Text(REMOVE_BUTTON),
        onPressed: () => ListBloc().deSelectItem(widget.id)
    ):
    RaisedButton(
        child: Text(SELECT_BUTTON),
        onPressed: () => ListBloc().selectItem(widget.id),
    );
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(item.selected?getSelectedTitle(item.title):item.title, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(item.description),
          button
        ],
      ),
    );
  }


}
