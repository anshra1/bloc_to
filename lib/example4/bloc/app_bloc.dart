import 'package:bloc/bloc.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
part 'app_event.dart';
part 'app_state.dart';
 
typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);
typedef AppBlocUrlLoader = Future<Uint8List> Function(String url);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppStateInitial> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  Future<Uint8List> _loadUrl(String url) => NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((byte) => byte.buffer.asUint8List());

  AppBloc({
    AppBlocRandomUrlPicker? urlPicker,
    required Iterable<String> urls,
    AppBlocUrlLoader? urlLoader,
    Duration? waitBeforeLoading,
  }) : super(const AppStateInitial.empty()) {
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
        final data = await (urlLoader ?? _loadUrl)(url);
        print('in try ');
        emit(
          AppStateInitial(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        print('in catch');
        emit(
          AppStateInitial(
            isLoading: false,
            data: null,
            error: e,
          ),
        );
      }
    });
  }
}
