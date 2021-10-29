import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;

  final child;

  final function;

  final longPress;

  MyButton({this.color, this.child, this.function, this.longPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: function,
        onLongPress: longPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: color,
            height: 55,
            width: 55,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
