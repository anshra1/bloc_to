import 'package:bloc_learning/example4/bloc/app_bloc.dart';

class BottomBloc extends AppBloc {
  BottomBloc({
    required Iterable<String> urls,
    Duration? duration,
  }) : super(
          urls: urls,
          waitBeforeLoading: duration,
        );
}
