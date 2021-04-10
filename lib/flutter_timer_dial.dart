import 'dart:math';

import 'package:flutter/material.dart';

import 'flutter_timer_knob.dart';

class FlutterTimerDial extends StatefulWidget {
  final Duration currentTime;
  final Duration maxTime;
  final int tickPerSection;
  final Function(Duration) onTimeSelected;
  final Function(Duration) onDialStopTurning;

  FlutterTimerDial(
      {this.tickPerSection = 5,
      this.onTimeSelected,
      this.onDialStopTurning,
      this.currentTime = const Duration(minutes: 0),
      this.maxTime = const Duration(minutes: 35)});

  @override
  _FlutterTimerDialState createState() => _FlutterTimerDialState();
}

class _FlutterTimerDialState extends State<FlutterTimerDial> {
  _rotationPercent() {
    return widget.currentTime.inSeconds / widget.maxTime.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterDialGestureDetector(
      currentTime: widget.currentTime,
      maxTime: widget.maxTime,
      onTimeSelected: widget.onTimeSelected,
      onDialStopTurning: widget.onDialStopTurning,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(55),
                      child: CustomPaint(
                        painter: TickPainter(
                          tickCount: widget.maxTime.inMinutes,
                          tickPerSection: widget.tickPerSection,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(65),
                    child:
                        FlutterTimerKnob(rotationPercent: _rotationPercent()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlutterDialGestureDetector extends StatefulWidget {
  final currentTime;
  final maxTime;
  final onTimeSelected;
  final onDialStopTurning;
  final child;

  FlutterDialGestureDetector(
      {this.child,
      this.onDialStopTurning,
      this.currentTime,
      this.maxTime,
      this.onTimeSelected});
  @override
  _FlutterDialGestureDetectorState createState() =>
      _FlutterDialGestureDetectorState();
}

class _FlutterDialGestureDetectorState
    extends State<FlutterDialGestureDetector> {
  PolarCoord startDragCoord;
  Duration startDragTime;
  Duration selectedTime;

  _onPanStart(DragStartDetails details) {
    startDragCoord = _polarCoordFromGlobalOffset(details.globalPosition);
    startDragTime = widget.currentTime;
  }

  _onPanUpdate(DragUpdateDetails details) {
    PolarCoord coord = _polarCoordFromGlobalOffset(details.globalPosition);
    if (startDragCoord != null) {
      var angleDiff = coord.angle - startDragCoord.angle;
      angleDiff = angleDiff >= 0 ? angleDiff : angleDiff + (2 * pi);
      final anglePercent = angleDiff / (2 * pi);
      final timeDiffInSeconds =
          (anglePercent * widget.maxTime.inSeconds).round();

      final selectedTime =
          Duration(seconds: startDragTime.inSeconds + timeDiffInSeconds);

      print('time: ${selectedTime.inMinutes}');
      widget.onTimeSelected(selectedTime);
    }
  }

  _onPanEnd(DragEndDetails details) {
    widget.onDialStopTurning(selectedTime);

    startDragCoord = null;
    startDragTime = null;
    selectedTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: widget.child,
    );
  }

  _polarCoordFromGlobalOffset(globalOffset) {
    final localToughOffset =
        (context.findRenderObject() as RenderBox).globalToLocal(globalOffset);
    final localToughPoint = Point(localToughOffset.dx, localToughOffset.dy);

    final originPoint = Point(context.size.width / 2, context.size.height / 2);

    return PolarCoord.fromPoints(originPoint, localToughPoint);
  }
}

class PolarCoord {
  final double angle;
  final double radius;

  factory PolarCoord.fromPoints(Point origin, Point point) {
    final vectorPoint = point - origin;
    final vector = Offset(vectorPoint.x, vectorPoint.y);

    return PolarCoord(
      vector.direction,
      vector.distance,
    );
  }

  PolarCoord(this.angle, this.radius);
}

class TickPainter extends CustomPainter {
  final longTick = 14;
  final shortTick = 4.0;

  final tickCount;
  final tickPerSection;
  final tickInsets;
  final tickPaint;
  final textPainter;
  final textStyle;

  TickPainter(
      {this.tickCount = 35, this.tickInsets = 0, this.tickPerSection = 5})
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
        textStyle = TextStyle(
          color: Colors.white,
          fontSize: 16,
        ) {
    tickPaint.color = Color(0xFF333949);
    tickPaint.strokeWidth = 1.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final radius = size.width / 2;
    canvas.translate(radius, radius);

    canvas.save();

    for (int i = 0; i < tickCount; ++i) {
      final tickLength = i % tickPerSection == 0 ? longTick : shortTick;
      canvas.drawLine(
          Offset(0, -radius), Offset(0, -radius - tickLength), tickPaint);
      if (i % tickPerSection == 0) {
        canvas.save();
        canvas.translate(0, -radius - 30);
        textPainter.text = TextSpan(
          text: '$i',
          style: textStyle,
        );
        textPainter.layout();
        final tickPercent = i / tickCount;
        var quadrant;
        if (tickPercent < 0.25) {
          quadrant = 1;
        } else if (tickPercent < 0.5) {
          quadrant = 4;
        } else if (tickPercent < 0.75) {
          quadrant = 3;
        } else {
          quadrant = 2;
        }

        switch (quadrant) {
          case 1:
            break;
          case 4:
            canvas.rotate(-pi / 2);
            break;
          case 3:
          case 2:
            canvas.rotate(pi / 2);
            break;
        }

        textPainter.paint(
            canvas,
            Offset(
              -textPainter.width / 2,
              -textPainter.height / 2,
            ));

        canvas.restore();
      }
      canvas.rotate(2 * pi / tickCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
