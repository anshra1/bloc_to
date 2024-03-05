import 'package:bloc/bloc.dart';
import 'package:bloc_learning/example3/apis/login_api.dart';
import 'package:bloc_learning/example3/apis/notes_api.dart';
import 'package:bloc_learning/example3/bloc/bloc/app_state.dart';
import 'package:bloc_learning/example3/enum.dart';
import 'package:bloc_learning/example3/login_handle_model.dart';
part 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppStateIntial> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
  final LoginHandle acceptedLoginHandle;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
    required this.acceptedLoginHandle,
  }) : super(const AppStateIntial.empty()) {
    on<AppLogin>(
      (event, emit) async {
        // start loading
        emit(
          const AppStateIntial(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchNotes: null,
          ),
        );

        // log the user in
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );

        emit(
          AppStateIntial(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchNotes: null,
          ),
        );
      },
    );

    on<LoadNotesEvent>(
      (event, emit) async {
       emit(
          AppStateIntial(
            isLoading: true,
            loginError: null,
            loginHandle: state.loginHandle,
            fetchNotes: null,
          ),
       );

        // get the login handle
        final loginHandle = state.loginHandle;
        if (loginHandle != acceptedLoginHandle) {
          // invalid login handle cannot fetch data
          emit(
            AppStateIntial(
              isLoading: false,
              loginError: LoginErrors.invalidHandle,
              loginHandle: loginHandle,
              fetchNotes: null,
            ),
          );
          return;
        } else {
          // this is valid login handle
          final notes = await notesApi.getNotes(loginHandle: loginHandle!);

          emit(
            AppStateIntial(
              isLoading: false,
              loginError: null,
              loginHandle: loginHandle,
              fetchNotes: notes,
            ),
          );
        }
      },
    );
  }
}
