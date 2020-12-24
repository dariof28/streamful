import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streamful/streamful.dart';

main() {
  Stream<String> _getStreamData(String value) {
    final controller = StreamController<String>();
    controller.add(value);
    controller.close();

    return controller.stream;
  }

  Stream<String> _getStreamError(String value) {
    final controller = StreamController<String>();
    controller.addError(value);
    controller.close();

    return controller.stream;
  }

  Stream<String> _getEmptyStream() {
    final controller = StreamController<String>();
    controller.close();

    return controller.stream;
  }

  testWidgets('StreamWidget with data returns onData result',
      (WidgetTester tester) async {
    var widget = StreamWidget<String>(
      stream: _getStreamData('success'),
      onData: (data) => Text(data, textDirection: TextDirection.ltr),
      onError: (_) => Text('error', textDirection: TextDirection.ltr),
      onLoad: Text('loading...', textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    expect(find.text('success'), findsOneWidget);
    expect(find.text('error'), findsNothing);
    expect(find.text('loading...'), findsNothing);
  });

  testWidgets('StreamWidget with errors returns onError result',
      (WidgetTester tester) async {
    var widget = StreamWidget<String>(
      stream: _getStreamError('error'),
      onData: (_) => Text('success', textDirection: TextDirection.ltr),
      onError: (object) => Text(object, textDirection: TextDirection.ltr),
      onLoad: Text('loading...', textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    expect(find.text('error'), findsOneWidget);
    expect(find.text('success'), findsNothing);
    expect(find.text('loading...'), findsNothing);
  });

  testWidgets('StreamWidget without data nor errors returns onLoad result',
      (WidgetTester tester) async {
    var widget = StreamWidget<String>(
      stream: _getEmptyStream(),
      onData: (_) => Text('success', textDirection: TextDirection.ltr),
      onError: (_) => Text('error', textDirection: TextDirection.ltr),
      onLoad: Text('loading...', textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    expect(find.text('loading...'), findsOneWidget);
    expect(find.text('success'), findsNothing);
    expect(find.text('error'), findsNothing);
  });

  testWidgets('StreamWidget with data without onData returns Container',
      (WidgetTester tester) async {
    var widget = StreamWidget<String>(
      stream: _getStreamData('success'),
      onError: (_) => Text('error', textDirection: TextDirection.ltr),
      onLoad: Text('loading...', textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    expect(find.byType(Container), findsOneWidget);
    expect(find.text('error'), findsNothing);
    expect(find.text('loading...'), findsNothing);
  });

  testWidgets('StreamWidget with errors without onError returns Container',
      (WidgetTester tester) async {
    var widget = StreamWidget<String>(
      stream: _getStreamError('error'),
      onData: (_) => Text('success', textDirection: TextDirection.ltr),
      onLoad: Text('loading...', textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    expect(find.byType(Container), findsOneWidget);
    expect(find.text('success'), findsNothing);
    expect(find.text('loading...'), findsNothing);
  });

  testWidgets(
      'StreamWidget without data nor errors without onLoad returns Container',
      (WidgetTester tester) async {
    var widget = StreamWidget<String>(
      stream: _getEmptyStream(),
      onData: (_) => Text('success', textDirection: TextDirection.ltr),
      onError: (_) => Text('error', textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    expect(find.byType(Container), findsOneWidget);
    expect(find.text('success'), findsNothing);
    expect(find.text('error'), findsNothing);
  });
}
