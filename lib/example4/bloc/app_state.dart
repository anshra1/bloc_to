part of 'app_bloc.dart';

abstract class AppState  {
  const AppState();
}

class AppStateInitial extends AppState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const AppStateInitial({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error
      }.toString();

  const AppStateInitial.empty()
      : isLoading = false,
        data = null,
        error = null;

}
