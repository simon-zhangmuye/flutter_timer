import 'package:flutter/material.dart';

class FlutterTimerText extends StatefulWidget {
  @override
  _FlutterTimerTextState createState() => _FlutterTimerTextState();
}

class _FlutterTimerTextState extends State<FlutterTimerText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Text(
        '12:32',
        style: TextStyle(
          color: Colors.white,
          fontSize: 100,
          fontWeight: FontWeight.bold,
          letterSpacing: 10,
        ),
      ),
    );
  }
}
