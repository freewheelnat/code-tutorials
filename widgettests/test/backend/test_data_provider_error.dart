import 'package:widgettests/list/list_bloc.dart';
import 'package:widgettests/list/model.dart';

const String ERROR_MESSAGE = "This is an error message";

class TestDataProviderError implements ItemsDataProvider {

  @override
  Future<ListOfItems> loadItems() {
    return Future.value(ListOfItems(null, ERROR_MESSAGE));
  }

}

