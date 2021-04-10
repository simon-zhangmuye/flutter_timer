import 'package:flutter/material.dart';

class FlutterTimerButton extends StatelessWidget {
  final IconData icon;
  final String text;

  FlutterTimerButton({this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFE346E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFB689E), width: 3),
        ),
        child: RawMaterialButton(
          onPressed: () {},
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
