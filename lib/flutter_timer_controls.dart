import 'package:flutter/material.dart';

import 'flutter_timer_button.dart';

class FluterTimerControls extends StatefulWidget {
  @override
  _FluterTimerControlsState createState() => _FluterTimerControlsState();
}

class _FluterTimerControlsState extends State<FluterTimerControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FlutterTimerButton(icon: Icons.refresh, text: 'RESTART'),
            Expanded(child: Container()),
            FlutterTimerButton(icon: Icons.arrow_back, text: 'RESET'),
          ],
        ),
        FlutterTimerButton(icon: Icons.pause, text: 'PAUSE'),
      ],
    );
  }
}
