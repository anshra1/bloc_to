import 'package:bloc_learning/example3/enum.dart';
import 'package:bloc_learning/example3/login_handle_model.dart';
import 'package:bloc_learning/example3/note_model.dart';
import 'package:collection/collection.dart';

class AppStateIntial {
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchNotes;

  const AppStateIntial({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.fetchNotes,
  });

  const AppStateIntial.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchNotes = null;

  @override
  String toString() {
    return 'AppStateIntial(isLoading: $isLoading, loginError: $loginError, loginHandle: $loginHandle, fetchNotes: $fetchNotes)';
  }

  @override
  bool operator ==(covariant AppStateIntial other) {
    final otherPropertiesAreEquel = isLoading == other.isLoading &&
        loginError == other.loginError &&
        loginHandle == other.loginHandle;

    if (fetchNotes == null && other.fetchNotes == null) {
      return otherPropertiesAreEquel;
    } else {
      return otherPropertiesAreEquel &&
          (fetchNotes?.isEqualTo(other.fetchNotes) ?? false);
    }
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      loginError.hashCode ^
      loginHandle.hashCode ^
      fetchNotes.hashCode;
}

extension UnorderEquality on Object {
  bool isEqualTo(other) =>
      const DeepCollectionEquality.unordered().equals(this, other);
}
