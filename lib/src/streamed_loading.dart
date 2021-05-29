import 'package:flutter/material.dart';

/// A Circular indicator to be showed when the given [stream] value is true.
class StreamedLoading extends StatelessWidget {
  /// The stream being used as toggle.
  final Stream<bool> stream;

  /// The color of the indicator.
  ///
  /// If null [ThemeData.accentColor] will be used.
  final Color? color;

  /// The width of the line of the indicator.
  final double strokeWidth;

  StreamedLoading({
    Key? key,
    required this.stream,
    this.color,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(color),
                strokeWidth: strokeWidth,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
