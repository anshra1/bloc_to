import 'package:bloc_learning/example3/apis/login_api.dart';
import 'package:bloc_learning/example3/apis/notes_api.dart';
import 'package:bloc_learning/example3/bloc/bloc/app_bloc.dart';
import 'package:bloc_learning/example3/bloc/bloc/app_state.dart';
import 'package:bloc_learning/example3/dialog/generic_dialog.dart';
import 'package:bloc_learning/example3/dialog/loading_screen.dart';
import 'package:bloc_learning/example3/login_handle_model.dart';
import 'package:bloc_learning/example3/strings.dart';
import 'package:bloc_learning/example3/views/iterable_list_view.dart';
import 'package:bloc_learning/example3/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppBloc(
        loginApi: LoginApis.instance(),
        notesApi: NotesApi(),
        acceptedLoginHandle: const LoginHandle.foobar()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homepage),
        ),
        body: BlocConsumer<AppBloc, AppStateIntial>(
          listener: ((context, appState) {
            // loading screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }

            // login errors
            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                titele: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuildr: () => {ok: true},
              );
            }
            // if we logged in, we have no fetched Notes , fetch them now

            if (appState.loginHandle == const LoginHandle.foobar() &&
                appState.isLoading == false) {
              context.read<AppBloc>().add(const LoadNotesEvent());
            }
          }),
          builder: (context, appState) {
            final notes = appState.fetchNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                         AppLogin(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
