import 'package:bloc_learning/example4/extensions/stream/start_with.dart';

void main() {
  Stream.periodic(
    const Duration(seconds: 2),
    (_) => 'const LoadNextUrlEvent()1',
  ).startWith('const LoadNextUrlEvent()2').forEach(
    (event) {
      print(event);
    },
  );
}
