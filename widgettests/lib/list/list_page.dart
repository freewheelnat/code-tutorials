import 'package:flutter/material.dart';
import 'package:widgettests/details/details_page.dart';
import 'package:widgettests/list/model.dart';
import 'package:widgettests/list/list_bloc.dart';
import 'package:widgettests/strings.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  void initState() {
    super.initState();
    ListBloc().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LIST_PAGE_TITLE),
      ),
      body: StreamBuilder<ListOfItems>(
        stream: ListBloc().outItems,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<ListOfItems> snapshot) {
          if (snapshot.hasError) {
            return _displayErrorMessage(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.errorMessage != null){
            return _displayErrorMessage(snapshot.data.errorMessage);
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data.items.map((Item value) {
                return _buildListRow(value);
              }).toList(),
            );
          }
        },
      )
    );
  }

  Widget _displayErrorMessage(String errorMessage) {
    return Container(padding: EdgeInsets.all(16.0),child: Center(child: Text('Error: $errorMessage')));
  }

  Widget _buildListRow(Item item) {
    return Container(
        color: item.selected?Colors.green.shade200:Colors.white,
        child: ListTile(
          title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold),),
          onTap: () {
            _displayDetails(item);
          },
        )
    );
  }

  void _displayDetails(Item item) async {
    await Navigator.of(context).push(
        new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return DetailsPage(id: item.id);
          },
        )
    );
  }


}
