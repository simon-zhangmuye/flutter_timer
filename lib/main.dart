import 'package:flutter/material.dart';

import 'flutter_timer.dart';
import 'flutter_timer_controls.dart';
import 'flutter_timer_dial.dart';
import 'flutter_timer_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterTimer flutterTimer;

  _MyAppState()
      : flutterTimer = FlutterTimer(maxTime: const Duration(minutes: 35));

  _onTimeSelected(Duration newTime) {
    setState(() {
      flutterTimer.currentTime = newTime;
    });
  }

  _onDialStopTurning(Duration newTime) {
    flutterTimer.currentTime = newTime;
    flutterTimer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF0B0F18),
        body: Center(
          child: Column(
            children: [
              FlutterTimerText(),
              FlutterTimerDial(
                currentTime: flutterTimer.currentTime,
                maxTime: flutterTimer.maxTime,
                tickPerSection: 5,
                onTimeSelected: _onTimeSelected,
                onDialStopTurning: _onDialStopTurning,
              ),
              Expanded(
                child: Container(),
              ),
              FluterTimerControls(),
            ],
          ),
        ),
      ),
    );
  }
}
