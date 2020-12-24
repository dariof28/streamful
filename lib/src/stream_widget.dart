import 'package:flutter/material.dart';

typedef DataCallBack<T> = Widget Function(T data);
typedef ErrorCallBack<Object> = Widget Function(Object error);

/// Wrapper of StreamBuilder.
///
/// You can pass an [onData] callback that will return a Widget that can deal with stream data.
/// You can pass an [onError] callback that will return a Widget that can deal with the stream error.
/// You can pass an [onLoad] widget to be returned while stream has no data nor errors.
///
/// If onData, onError or onLoad are null, a Container is returned.
class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final DataCallBack<T> onData;
  final ErrorCallBack<Object> onError;
  final Widget onLoad;

  StreamWidget({@required this.stream, this.onData, this.onError, this.onLoad});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (onError != null) {
            return onError(snapshot.error);
          }

          return Container();
        }

        if (snapshot.hasData) {
          if (onData != null) {
            return onData(snapshot.data);
          }

          return Container();
        }

        return onLoad ?? Container();
      },
    );
  }
}
