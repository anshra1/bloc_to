import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
part 'app_event.dart';
part 'app_state.dart';

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppStateInitial> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc({
    AppBlocRandomUrlPicker? urlPicker,
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
  }) : super(
          const AppStateInitial.empty(),
        ) {
    on<LoadNextUrlEvent>((event, emit) async {
      emit(
        const AppStateInitial(
          isLoading: true,
          data: null,
          error: null,
        ),
      );

      final url = (urlPicker ?? _pickRandomUrl)(urls);

      try {
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();

        emit(
          AppStateInitial(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        AppStateInitial(
          isLoading: true,
          data: null,
          error: e,
        );
      }
    });
  }
}
