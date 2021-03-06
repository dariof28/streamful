import 'package:rxdart/rxdart.dart';
import 'package:streamful/src/streamed_loading.dart';

/// Use this class as mixin for BLoC where you need a loading stream for example
/// to show a [StreamedLoading]
abstract class Loading {
  final _loadingController = BehaviorSubject<bool>();

  Stream<bool> get isLoading => _loadingController.stream;

  /// Use this method to set the loading Stream to true
  void loadStart() => _loadingController.add(true);

  /// Use this method to set the loading Stream to false
  void loadStop() => _loadingController.add(false);
}
