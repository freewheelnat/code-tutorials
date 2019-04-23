import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgettests/details/details_page.dart';
import 'package:widgettests/list/list_bloc.dart';
import 'package:widgettests/strings.dart';

import '../backend/test_data_provider.dart';

void main() {

  testWidgets('Selected item is shown as selected', (WidgetTester tester) async {

    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageSelectedWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final titleFinder = _getSelectedTitleFinder(ITEM_TITLE_ALPHA_2);
    final pageTitleFinder = _getTitleFinder(ITEM_TITLE_ALPHA_2);
    final buttonFinder = _getRemoveButtonFinder();

    expect(titleFinder, findsOneWidget);
    expect(pageTitleFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Unselected item is shown as unselected', (WidgetTester tester) async {

    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageUnselectedWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final titleFinder = _getTitleFinder(ITEM_TITLE_ALPHA_1);
    final buttonFinder = _getSelectButtonFinder();

    expect(titleFinder, findsNWidgets(2));
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Select unselected item updates widget and stream', (WidgetTester tester) async {
    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageUnselectedWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final buttonFinder = _getSelectButtonFinder();
    await tester.tap(buttonFinder);

    // Trigger widget to redraw its frames, this causes the stream builder to get the new data
    await tester.pump(Duration.zero);

    final titleFinder = _getSelectedTitleFinder(ITEM_TITLE_ALPHA_1);
    final pageTitleFinder = _getTitleFinder(ITEM_TITLE_ALPHA_1);
    final buttonFinder2 = _getRemoveButtonFinder();

    expect(titleFinder, findsOneWidget);
    expect(pageTitleFinder, findsOneWidget);
    expect(buttonFinder2, findsOneWidget);
  });

  testWidgets('Unselect selected item updates widget and stream', (WidgetTester tester) async {
    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageSelectedWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final buttonFinder = _getRemoveButtonFinder();
    await tester.tap(buttonFinder);

    // Trigger widget to redraw its frames, this causes the stream builder to get the new data
    await tester.pump(Duration.zero);

    final titleFinder = _getTitleFinder(ITEM_TITLE_ALPHA_2);
    final buttonFinder2 = _getSelectButtonFinder();

    expect(titleFinder, findsNWidgets(2));
    expect(buttonFinder2, findsOneWidget);
  });

}

Finder _getSelectButtonFinder() {
  return find.text(SELECT_BUTTON);
}

Finder _getRemoveButtonFinder() {
  return find.text(REMOVE_BUTTON);
}

Finder _getTitleFinder(String title) {
  return find.text(title);
}

Finder _getSelectedTitleFinder(String title) {
  return find.text(getSelectedTitle(title));
}

class DetailsPageUnselectedWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DetailsPage(id: ITEM_ID_ALPHA_1),
    );
  }
}

class DetailsPageSelectedWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DetailsPage(id: ITEM_ID_ALPHA_2),
    );
  }
}
