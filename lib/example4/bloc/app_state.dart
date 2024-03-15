part of 'app_bloc.dart';

abstract class AppState {
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

  const AppStateInitial.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  bool operator ==(covariant AppStateInitial other) =>
      isLoading == other.isLoading &&
      (data ?? []).isEquelTo(other.data ?? []) ;

  @override
  int get hashCode => Object.hash(isLoading, data);

  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error
      }.toString();
}

extension Comparison<E> on List<E> {
  bool isEquelTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }

    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
