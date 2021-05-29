import 'package:rxdart/rxdart.dart';
import 'package:streamful/streamful.dart';

class MyBloc with Loading {
  final _dataController = BehaviorSubject<String?>();

  Stream<String?> get data => _dataController.stream;

  Future<void> getData() async {
    loadStart();
    _dataController.add(null);

    await Future.delayed(Duration(seconds: 2));
    _dataController.add('Data retrieved!');

    loadStop();
  }

  Future<void> getError() async {
    loadStart();
    _dataController.add(null);

    await Future.delayed(Duration(seconds: 2));
    _dataController.addError(Exception('Error Occurred!'));

    loadStop();
  }
}

final bloc = MyBloc();
