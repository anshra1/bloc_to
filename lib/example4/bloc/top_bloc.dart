import 'package:bloc_learning/example4/bloc/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({
    required Iterable<String> urls,
    Duration? duration,
  }) : super(
          urls: urls,
          waitBeforeLoading: duration,
        );
}
