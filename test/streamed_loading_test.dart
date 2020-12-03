import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streamful/streamful.dart';

main() {
  Stream<bool> _getStream(bool value) {
    final controller = StreamController<bool>();
    controller.add(value);
    controller.close();

    return controller.stream;
  }

  testWidgets('Display a Container if stream value is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(StreamedLoading(stream: _getStream(false)));
    await tester.pump(Duration.zero);

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(Container), findsOneWidget);
  });

  testWidgets('Display a CircularProgressIndicator if stream value is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(StreamedLoading(stream: _getStream(true)));
    await tester.pump(Duration.zero);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Can customize CircularProgressIndicator color',
      (WidgetTester tester) async {
    var color = Colors.red;

    await tester.pumpWidget(StreamedLoading(
      stream: _getStream(true),
      color: color,
    ));
    await tester.pump(Duration.zero);

    WidgetPredicate predicate = (Widget widget) =>
        widget is CircularProgressIndicator &&
        widget.valueColor is AlwaysStoppedAnimation &&
        widget.valueColor.value == color;
    expect(find.byWidgetPredicate(predicate), findsOneWidget);
  });

  testWidgets('Can customize CircularProgressIndicator strokeWidth',
      (WidgetTester tester) async {
    var width = 8.0;

    await tester.pumpWidget(StreamedLoading(
      stream: _getStream(true),
      strokeWidth: width,
    ));
    await tester.pump(Duration.zero);

    WidgetPredicate predicate = (Widget widget) =>
        widget is CircularProgressIndicator && widget.strokeWidth == width;
    expect(find.byWidgetPredicate(predicate), findsOneWidget);
  });

  testWidgets('CircularProgressIndicator strokeWidth is 4.0 by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(StreamedLoading(stream: _getStream(true)));
    await tester.pump(Duration.zero);

    WidgetPredicate predicate = (Widget widget) =>
        widget is CircularProgressIndicator && widget.strokeWidth == 4.0;
    expect(find.byWidgetPredicate(predicate), findsOneWidget);
  });
}
