import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:widgettests/list/model.dart';
import 'package:widgettests/list/list_bloc.dart';

///
/// Due to the UI of the app, there is only one DetailsPage at any time. Therefore,
/// we can use a singleton Bloc. If there could be several instances of DetailsPage
/// in the widget tree at a given time, we would need to add the item id as a
/// parameter to the Bloc class.
///
class DetailsBloc {

  static final DetailsBloc _singleton = new DetailsBloc._internal();

  factory DetailsBloc() {
    return _singleton;
  }

  DetailsBloc._internal();

  BehaviorSubject<Item> _itemController = BehaviorSubject<Item>();
  Stream<Item> get outItem => _itemController.stream;
  StreamSubscription _subscription;
  int _currentId;

  void getItem(int id) async {
    // Reset the item
    _itemController.sink.add(null);

    _currentId = id;
    if (_subscription != null) {
      _subscription.cancel();
    }

    _subscription = ListBloc().outItems.listen((listOfItems) async {
      for (var item in listOfItems.items){
        if (item.id == _currentId) {
          _itemController.sink.add(item);
          break;
        }
      }
    });
  }

  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }
    _itemController.close();
  }

}
