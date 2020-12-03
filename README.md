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