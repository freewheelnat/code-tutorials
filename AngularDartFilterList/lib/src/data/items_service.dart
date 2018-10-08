import 'package:AngularDartFilterList/src/data/item.dart';
import 'dart:async';

class ItemsService {

  List<Item> _items;

  Future<List<Item>> getItems(String filter) async {

    // We return the cached items if available.
    // In a real world web app, depending on the domain of your web app,
    // you may want to either invalidate the cache after x minutes (eg for a small merchandise store),
    // or use a backend with server side events functionality such as Firebase (eg for a chat app)
    if (_items != null) {
      return _filterCachedItems(filter);
    }

    // Here, we simulate a server call by waiting for 2 seconds...
    await Future.delayed(Duration(seconds: 2));

    _items = _getHardcodedItems();

    return _filterCachedItems(filter);
  }

  List<Item> _filterCachedItems(String filter) {
    if (filter == '') {
      return _items;
    }

    List<Item> list = List<Item>();
    for (var item in _items) {
      if (item.display.toLowerCase().contains(filter.toLowerCase())) {
        list.add(item);
      }
    }

    return list;
  }

  /**
   * This is for demo only.
   */
  List<Item> _getHardcodedItems() {
    List<Item> list = List<Item>();
    list.add(Item("1", "Charles Dickens"));
    list.add(Item("2", "Paul Auster"));
    list.add(Item("3", "Jane Austen"));
    list.add(Item("4", "H.G. Wells"));
    list.add(Item("5", "Agatha Christie"));
    list.add(Item("6", "Jonathan Franzen"));
    list.add(Item("7", "Maya Angelou"));
    list.add(Item("8", "Sarah Waters"));
    list.add(Item("9", "Jules Verne"));
    list.add(Item("10", "Naomi Klein"));
    list.add(Item("11", "Paula Hawkins"));
    list.add(Item("12", "Philip Roth"));
    return list;
  }

}