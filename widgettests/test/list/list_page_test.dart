import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgettests/list/list_bloc.dart';
import 'package:widgettests/list/list_page.dart';

import '../backend/test_data_provider.dart';
import '../backend/test_data_provider_error.dart';

void main() {

  testWidgets('Items are displayed', (WidgetTester tester) async {

    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());

    // Build widget
    await tester.pumpWidget(ListPageWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final item1Finder = find.text(ITEM_TITLE_ALPHA_1);
    final item2Finder = find.text(ITEM_TITLE_ALPHA_2);
    final item3Finder = find.text(ITEM_TITLE_ALPHA_3);
    expect(item1Finder, findsOneWidget);
    expect(item2Finder, findsOneWidget);
    expect(item3Finder, findsOneWidget);

    // Under the hood, Container uses BoxDecoration when setting color
    WidgetPredicate widgetSelectedPredicate = (Widget widget) => widget is Container && widget.decoration == BoxDecoration(color: Colors.green.shade200);
    WidgetPredicate widgetUnselectedPredicate = (Widget widget) => widget is Container && widget.decoration == BoxDecoration(color: Colors.white);

    expect(find.byWidgetPredicate(widgetSelectedPredicate), findsOneWidget);
    expect(find.byWidgetPredicate(widgetUnselectedPredicate), findsNWidgets(2));
  });

  testWidgets('Error message is displayed when server error', (WidgetTester tester) async {

    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProviderError());

    await tester.pumpWidget(ListPageWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final errorFinder = find.text("Error: " + ERROR_MESSAGE);

    expect(errorFinder, findsOneWidget);
  });

  testWidgets('Widget is updated when stream is updated', (WidgetTester tester) async {

    // Inject error data provider
    ListBloc().injectDataProviderForTest(TestDataProviderError());

    await tester.pumpWidget(ListPageWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final errorFinder = find.text("Error: " + ERROR_MESSAGE);

    expect(errorFinder, findsOneWidget);

    // Inject no error data provider, trigger stream update
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Trigger widget to redraw its frames, this causes the stream builder to get the new data
    await tester.pump(Duration.zero);

    final item1Finder = find.text(ITEM_TITLE_ALPHA_1);
    final item2Finder = find.text(ITEM_TITLE_ALPHA_2);
    final item3Finder = find.text(ITEM_TITLE_ALPHA_3);

    expect(item1Finder, findsOneWidget);
    expect(item2Finder, findsOneWidget);
    expect(item3Finder, findsOneWidget);

  });

}


class ListPageWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ListPage(),
    );
  }
}
