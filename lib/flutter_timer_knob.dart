import 'dart:math';

import 'package:flutter/material.dart';

class FlutterTimerKnob extends StatefulWidget {
  final rotationPercent;

  FlutterTimerKnob({this.rotationPercent});
  @override
  _FlutterTimerKnobState createState() => _FlutterTimerKnobState();
}

class _FlutterTimerKnobState extends State<FlutterTimerKnob> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: ArrowPainter(
              rotationPercent: widget.rotationPercent,
              //rotationPercent: widget.rotationPercent,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF15143E),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF201F49),
                    width: 1.5,
                  )),
              child: Center(
                child: Transform(
                  transform: Matrix4.rotationZ(2 * pi * widget.rotationPercent),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.toys_sharp,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  final dialArrowPaint;
  final rotationPercent;

  ArrowPainter({
    this.rotationPercent,
  }) : dialArrowPaint = Paint() {
    dialArrowPaint.color = Color(0xfff83571);
    dialArrowPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.save();
    final radius = size.width / 2;
    canvas.translate(radius, radius);
    canvas.rotate(2 * pi * rotationPercent);
    Path path = Path();
    path.moveTo(0, -radius - 10);
    path.lineTo(10, -radius + 5);
    path.lineTo(-10, -radius + 5);
    path.close();

    canvas.drawPath(path, dialArrowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
