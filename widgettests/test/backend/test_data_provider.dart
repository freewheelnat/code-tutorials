import 'package:widgettests/list/model.dart';
import 'package:widgettests/list/list_bloc.dart';

const String ITEM_TITLE_ALPHA_1 = "an item";
const String ITEM_TITLE_ALPHA_2 = "Before";
const String ITEM_TITLE_ALPHA_3 = "last";
const int ITEM_ID_ALPHA_1 = 2;
const int ITEM_ID_ALPHA_2 = 1;
const int ITEM_ID_ALPHA_3 = 3;
const bool ITEM_SELECTED_FALSE_ALPHA_1 = false;
const bool ITEM_SELECTED_TRUE_ALPHA_2 = true;
const bool ITEM_SELECTED_FALSE_ALPHA_3 = false;

class TestDataProvider implements ItemsDataProvider {

  @override
  Future<ListOfItems> loadItems() {
    List<Item> list = List<Item>();
    list.add(Item(ITEM_ID_ALPHA_2, ITEM_TITLE_ALPHA_2, "", ITEM_SELECTED_TRUE_ALPHA_2));
    list.add(Item(ITEM_ID_ALPHA_1, ITEM_TITLE_ALPHA_1, "", ITEM_SELECTED_FALSE_ALPHA_1));
    list.add(Item(ITEM_ID_ALPHA_3, ITEM_TITLE_ALPHA_3, "", ITEM_SELECTED_FALSE_ALPHA_3));
    return Future.value(ListOfItems(list, null));
  }

}
