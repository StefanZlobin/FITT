import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitt/domain/ticker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_error_timer_event.dart';
part 'authentication_error_timer_state.dart';
part 'authentication_error_timer_bloc.freezed.dart';

class AuthenticationErrorTimerBloc
    extends Bloc<AuthenticationErrorTimerEvent, AuthenticationErrorTimerState> {
  StreamSubscription<int>? _tickerSubscription;
  final Ticker _ticker;
  int attemptsEnterCode = 0;

  AuthenticationErrorTimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const _TimerInitial()) {
    on<_SetTimerInitial>(_onSetInitial);
    on<_TimerStarted>(_onStarted);
    //on<_TimerPaused>(_onPaused);
    //on<_TimerResumed>(_onResumed);
    //on<_TimerReset>(_onReset);
    on<_TimerTicked>(_onTicked);
  }

  void _onSetInitial(
    _SetTimerInitial event,
    Emitter<AuthenticationErrorTimerState> emit,
  ) {
    emit(_TimerInitial(duration: event.duration));
  }

  void _onStarted(
    _TimerStarted event,
    Emitter<AuthenticationErrorTimerState> emit,
  ) {
    emit(_TimerRunInProgress(duration: event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration.inSeconds)
        .listen((duration) => add(_TimerTicked(
              duration: Duration(seconds: duration),
            )));
  }

  void _onTicked(
    _TimerTicked event,
    Emitter<AuthenticationErrorTimerState> emit,
  ) {
    if (event.duration.inSeconds > 0) {
      emit(_TimerRunInProgress(duration: event.duration));
    } else {
      attemptsEnterCode += 1;
      emit(_TimerRunComplete(attemptsEnterCode: attemptsEnterCode));
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
