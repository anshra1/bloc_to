import 'package:bloc_learning/example3/apis/login_api.dart';
import 'package:bloc_learning/example3/apis/notes_api.dart';
import 'package:bloc_learning/example3/bloc/bloc/app_bloc.dart';
import 'package:bloc_learning/example3/bloc/bloc/app_state.dart';
import 'package:bloc_learning/example3/enum.dart';
import 'package:bloc_learning/example3/login_handle_model.dart';
import 'package:bloc_learning/example3/note_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

class MockNotesApi implements NotesApiProtocol {
  final LoginHandle loginHandles;
  final Iterable<Note>? notes;

  MockNotesApi({
    required this.loginHandles,
    required this.notes,
  });

  MockNotesApi.empty()
      : loginHandles = const LoginHandle.foobar(),
        notes = null;

  @override
  Future<Iterable<Note>?> getNotes({required loginHandle}) async {
    if (loginHandle == loginHandles) {
      return notes;
    } else {
      return null;
    }
  }
}

class MockLoginApi implements LoginApiProtocol {
  final String acceptedEmail;
  final String acceptedPassword;
  final LoginHandle handleToReturn;

  MockLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
    required this.handleToReturn,
  });

  const MockLoginApi.empty()
      : acceptedEmail = '',
        handleToReturn = const LoginHandle.foobar(),
        acceptedPassword = '';

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return handleToReturn;
    } else {
      return null;
    }
  }
}

void main() {
  blocTest<AppBloc, AppStateIntial>(
    'intial state of the bloc should be AppStateIntial.empty()',
    build: () => AppBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: const MockLoginApi.empty(),
      notesApi: MockNotesApi.empty(),
    ),
    verify: (state) {
      return expect(
        state.state,
        const AppStateIntial.empty(),
      );
    },
  );

  blocTest<AppBloc, AppStateIntial>(
    'can we login with correct credentials',
    build: () => AppBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: MockLoginApi(
        acceptedEmail: 'bar@bar.com',
        acceptedPassword: 'bar',
        handleToReturn: const LoginHandle(token: 'ABC'),
      ),
      notesApi: MockNotesApi.empty(),
    ),
    act: (appBloc) => appBloc.add(
      const AppLogin(email: 'bar@bar.com', password: 'bar'),
    ),
    expect: () {
      return [
        const AppStateIntial(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchNotes: null,
        ),
        const AppStateIntial(
          isLoading: false,
          loginError: null,
          loginHandle: LoginHandle(token: 'ABC'),
          fetchNotes: null,
        ),
      ];
    },
  );

  blocTest<AppBloc, AppStateIntial>(
    'we should not be able to log in with invalid credentials',
    build: () => AppBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: MockLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'bar',
        handleToReturn: const LoginHandle(token: 'ABC'),
      ),
      notesApi: MockNotesApi.empty(),
    ),
    act: (appBloc) => appBloc.add(
      const AppLogin(email: 'bar@bar.com', password: 'bar'),
    ),
    expect: () {
      return [
        const AppStateIntial(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchNotes: null,
        ),
        const AppStateIntial(
          isLoading: false,
          loginError: LoginErrors.invalidHandle,
          loginHandle: null,
          fetchNotes: null,
        ),
      ];
    },
  );

  blocTest<AppBloc, AppStateIntial>(
    'load some ntes with valid  login handle',
    build: () => AppBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: MockLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'bar',
        handleToReturn: const LoginHandle(token: 'ABC'),
      ),
      notesApi: MockNotesApi(
        loginHandles: const LoginHandle(token: 'ABC'),
        notes: mockNotes,
      ),
    ),
    act: (appBloc) {
      appBloc.add(
        const AppLogin(
          email: 'foo@bar.com',
          password: 'bar',
        ),
      );
      appBloc.add(const LoadNotesEvent());
    },
    expect: () {
      return [
        const AppStateIntial(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchNotes: null,
        ),
        const AppStateIntial(
          isLoading: false,
          loginError: null,
          loginHandle: LoginHandle(token: 'ABC'),
          fetchNotes: null,
        ),
        const AppStateIntial(
          isLoading: true,
          loginError: null,
          loginHandle: LoginHandle(token: 'ABC'),
          fetchNotes: null,
        ),
        const AppStateIntial(
          isLoading: false,
          loginError: null,
          loginHandle: LoginHandle(token: 'ABC'),
          fetchNotes: mockNotes,
        ),
      ];
    },
  );
}
