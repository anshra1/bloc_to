
import 'package:bloc_learning/bloc_countr/bloc/counter_bloc.dart';
import 'package:bloc_learning/bloc_countr/bloc/counter_state.dart';
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
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Counter Test'),
      ),
      body: Column(
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, index) {
              var s = index.count;
              return Center(
                  child: Text(
                s.toString(),
                style: const TextStyle(
                  fontSize: 35,
                ),
              ),);
            },
          ),
          TextButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrement());
            },
            child: const Text('Increment'),
          ),
          const Gap(10),
          TextButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrement());
            },
            child: const Text('Decrement'),
          ),
        ],
      ),
    );
  }
}
