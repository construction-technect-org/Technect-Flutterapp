import 'package:flutter/material.dart';

class WhiteCardWidget extends StatelessWidget {
  final Widget child;
  const WhiteCardWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
