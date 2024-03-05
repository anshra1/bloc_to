
import 'package:bloc_learning/bloc_listener/bloc/listener_test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
      create: (BuildContext context) => ListenerTestBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
        ),
        body: BlocConsumer<ListenerTestBloc, int>(
          listener: (BuildContext context, Object? state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('State is $state'),
                backgroundColor: Colors.green,
              ),
            );
          },
          builder: (BuildContext context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (state == 30) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('State is 10'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      context.read<ListenerTestBloc>().add(ListenerEvent());
                    },
                    child: Text('state is $state'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ListenerTestBloc>().add(Increment());
                    },
                    child: const Text('Increment'),
                  ),
                  const Gap(10),
                  TextButton(
                    onPressed: () {
                      context.read<ListenerTestBloc>().add(Decrement());
                    },
                    child: const Text('Decrement'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
