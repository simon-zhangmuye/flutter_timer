import 'dart:async';

class FlutterTimer {
  final Duration maxTime;
  final Stopwatch stopwatch = Stopwatch();
  Duration _currentTime = const Duration(seconds: 0);
  Duration lastStartTime = const Duration(seconds: 0);
  FlutterTimerState state = FlutterTimerState.ready;

  FlutterTimer({this.maxTime});

  get currentTime {
    return _currentTime;
  }

  set currentTime(newTime) {
    if (state == FlutterTimerState.ready) {
      _currentTime = newTime;
    }
  }

  resume() {
    state = FlutterTimerState.running;
    lastStartTime = _currentTime;
    stopwatch.start();

    _tick();
  }

  pause() {}

  _tick() {
    print('Current Time: ${_currentTime.inSeconds}');
    _currentTime = lastStartTime - stopwatch.elapsed;
    if (_currentTime.inSeconds > 0) {
      Timer(Duration(seconds: 1), _tick);
    } else {
      state = FlutterTimerState.ready;
    }
  }
}

enum FlutterTimerState {
  ready,
  running,
  paused,
}
