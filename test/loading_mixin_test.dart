import 'package:flutter_test/flutter_test.dart';
import 'package:streamful/src/loading_mixin.dart';

class MyClass with Loading {}

main() {
  test('Loading mixin can start loading', () async {
    var instance = new MyClass();
    instance.loadStart();

    expect(await instance.isLoading.first, true);
  });

  test('Loading mixin can stop loading', () async {
    var instance = new MyClass();
    instance.loadStop();

    expect(await instance.isLoading.first, false);
  });
}
