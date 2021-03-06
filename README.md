# streamful

Widgets and utilities to deal with streams

## Features

### StreamedLoading

A circular indicator that will show looking to a boolean stream representing the loading status.

You can customize stroke **size** and **color**.

```dart
StreamedLoading(
  stream: _loadingController.stream,
  color: Colors.Blue,
  strokeWidth: 4.0,
);
```

### Loading mixin

A mixin that adds a `BehaviorSubject<bool>` to a class. This way you can easily deal with a stream representing the loading status.

You can set the loading status using `loadStart()` and `loadStop()` functions.
To retrieve the loading status you can use the `isLoading` getter.

### StreamWidget

This is a wrapper of `StreamBuilder`. It allows to define:
- an `onData: (data) {}` callback that must return the Widget to show when the stream has data
- an `onError: (error) {}` callback that must return the Widget to show when the stream has errors
- an onLoad: widget to be returned when the stream has no data nor errors
