import 'package:bloc_learning/example3/login_handle_model.dart';
import 'package:bloc_learning/example3/note_model.dart';

abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

class NotesApi implements NotesApiProtocol {
  NotesApi();

  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginHandle == const LoginHandle.foobar(),
      ).then(
        (isLoggedIn) => isLoggedIn ? mockNotes : null,
      );
}
