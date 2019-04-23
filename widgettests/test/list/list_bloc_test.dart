import 'package:flutter_test/flutter_test.dart';
import 'package:widgettests/list/model.dart';
import 'package:widgettests/list/list_bloc.dart';

import '../backend/test_data_provider.dart';

void main() {
  test('Items are alphabetised, ignoring case', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    listBloc.loadItems();

    var events = await listBloc.outItems.take(1).toList();

    verifyTestData(events[0]);
  });

  test('Selecting an unselected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.selectItem(ITEM_ID_ALPHA_1);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);

    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), true);
    verifySelectedStatus(events[1].items.elementAt(1), ITEM_SELECTED_TRUE_ALPHA_2);
    verifySelectedStatus(events[1].items.elementAt(2), ITEM_SELECTED_FALSE_ALPHA_3);

  });

  test('Selecting a selected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.selectItem(ITEM_ID_ALPHA_2);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), ITEM_SELECTED_FALSE_ALPHA_1);
    verifySelectedStatus(events[1].items.elementAt(1), true);
    verifySelectedStatus(events[1].items.elementAt(2), ITEM_SELECTED_FALSE_ALPHA_3);

  });

  test('Unselecting a selected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.deSelectItem(ITEM_ID_ALPHA_2);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), ITEM_SELECTED_FALSE_ALPHA_1);
    verifySelectedStatus(events[1].items.elementAt(1), false);
    verifySelectedStatus(events[1].items.elementAt(2), ITEM_SELECTED_FALSE_ALPHA_3);

  });

  test('Unselecting an unselected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.deSelectItem(ITEM_ID_ALPHA_1);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), false);
    verifySelectedStatus(events[1].items.elementAt(1), ITEM_SELECTED_TRUE_ALPHA_2);
    verifySelectedStatus(events[1].items.elementAt(2), ITEM_SELECTED_FALSE_ALPHA_3);

  });

}

void verifyTestData(ListOfItems data) {
  verifyTestDataExceptSelected(data);
  verifySelectedStatus(data.items.elementAt(0), ITEM_SELECTED_FALSE_ALPHA_1);
  verifySelectedStatus(data.items.elementAt(1), ITEM_SELECTED_TRUE_ALPHA_2);
  verifySelectedStatus(data.items.elementAt(2), ITEM_SELECTED_FALSE_ALPHA_3);
}

void verifyTestDataExceptSelected(ListOfItems data) {
  expect(data.errorMessage, isNull);
  expect(data.items.length, equals(3));
  expect(data.items.elementAt(0).title, equals(ITEM_TITLE_ALPHA_1));
  expect(data.items.elementAt(1).title, equals(ITEM_TITLE_ALPHA_2));
  expect(data.items.elementAt(2).title, equals(ITEM_TITLE_ALPHA_3));
  expect(data.items.elementAt(0).id, equals(ITEM_ID_ALPHA_1));
  expect(data.items.elementAt(1).id, equals(ITEM_ID_ALPHA_2));
  expect(data.items.elementAt(2).id, equals(ITEM_ID_ALPHA_3));
}

void verifySelectedStatus(Item data, bool shouldBeSelected) {
  expect(data.selected, equals(shouldBeSelected));
}