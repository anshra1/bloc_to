import 'package:bloc_learning/example3/bloc/bloc/app_bloc.dart';
import 'package:bloc_learning/example4/bloc/bottom_bloc.dart';
import 'package:bloc_learning/example4/bloc/top_bloc.dart';
import 'package:bloc_learning/example4/model/constants.dart';
import 'package:bloc_learning/example4/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TopBloc(
                urls: images,
                duration: const Duration(seconds: 3),
              ),
            ),
            BlocProvider(
              create: (context) => BottomBloc(
                urls: images,
                duration: const Duration(seconds: 3),
              ),
            ),
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
