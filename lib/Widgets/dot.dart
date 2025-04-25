import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final bool active;

  const Dot({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.black : Colors.transparent,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}
