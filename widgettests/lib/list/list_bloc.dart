import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:widgettests/backend/backend_data.dart';
import 'package:widgettests/list/model.dart';

class ListBloc {

  static final ListBloc _singleton = new ListBloc._internal();

  factory ListBloc() {
    return _singleton;
  }

  ListBloc._internal();

  ItemsDataProvider provider = BackendData();

  BehaviorSubject<ListOfItems> _itemsController = BehaviorSubject<ListOfItems>();
  Stream<ListOfItems> get outItems => _itemsController.stream;

  Future loadItems() async {
    ListOfItems items = await provider.loadItems();
    if (items.items != null) {
      items.items.sort(_alphabetiseItemsByTitleIgnoreCases);
    }
    _itemsController.sink.add(items);
  }

  int _alphabetiseItemsByTitleIgnoreCases(Item a, Item b) {
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }

  void selectItem(int id) {
    StreamSubscription subscription;
    subscription = ListBloc().outItems.listen((listOfItems) async {
      List<Item> newList = List<Item>();
      for (var item in listOfItems.items){
        if (item.id == id) {
          newList.add(Item(item.id, item.title, item.description, true));
        } else {
          newList.add(item);
        }
      }
      _itemsController.sink.add(ListOfItems(newList, null));
      subscription.cancel();
    });
  }

  void deSelectItem(int id) {
    StreamSubscription subscription;
    subscription = ListBloc().outItems.listen((listOfItems) async {
      List<Item> newList = List<Item>();
      for (var item in listOfItems.items){
        if (item.id == id) {
          newList.add(Item(item.id, item.title, item.description, false));
        } else {
          newList.add(item);
        }
      }
      _itemsController.sink.add(ListOfItems(newList, null));
      subscription.cancel();
    });
  }

  void dispose() {
    _itemsController.close();
  }

  void injectDataProviderForTest(ItemsDataProvider provider) {
    this.provider = provider;
  }
}

abstract class ItemsDataProvider {
  Future<ListOfItems> loadItems();
}

