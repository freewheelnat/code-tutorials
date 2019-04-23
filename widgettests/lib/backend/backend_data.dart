import 'dart:async';
import 'dart:convert';
import 'package:widgettests/list/model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:widgettests/list/list_bloc.dart';

///
/// We are faking a backend, and instead load the data from the json file
///
class BackendData implements ItemsDataProvider {

  static final BackendData _singleton = new BackendData._internal();

  factory BackendData() {
    return _singleton;
  }

  BackendData._internal();

  @override
  Future<ListOfItems> loadItems() async {
    try {
      final parsed = List<dynamic>.from(json.decode(await rootBundle.loadString('assets/data.json'))['items']);
      final list = parsed.map((json) => Item.fromJson(json)).toList();
      return ListOfItems(list, null);
    } catch (exception) {
      // Do not display an exception directly to user in a real app, it's not a user friendly error message!
      return ListOfItems(null, exception.toString());
    }
  }

}