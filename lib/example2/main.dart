import 'package:bloc_to/example2/bloc/fetch_result.dart';

import 'package:bloc_to/example2/extension.dart';
import 'package:bloc_to/example2/bloc/load_action.dart';

import 'package:bloc_to/example2/bloc/person_bloc.dart';
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
        create: (_) => PersonBloc(),
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
        title: const Text('Bloc Test'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    context.read<PersonBloc>().add(
                          const LoadPersonsActions(url: PersonUrl.person1),
                        );
                  },
                  child: const Text('Load json #1'),
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {
                    context.read<PersonBloc>().add(
                          const LoadPersonsActions(url: PersonUrl.person2),
                        );
                  },
                  child: const Text('Load json #2'),
                ),
              ],
            ),
            BlocBuilder<PersonBloc, FetchResult?>(
              buildWhen: (previousResult, curreentResult) {
                return previousResult?.persons != curreentResult?.persons;
              },
              builder: (context, fetchResult) {
                fetchResult?.loged();
                final persons = fetchResult?.persons;

                if (persons == null) {
                  return Container();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        final person = persons[index]!;
                        return ListTile(
                          title: Text(person.name),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
