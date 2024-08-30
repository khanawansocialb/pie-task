import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final String leading;
  final String traling;
  const TextRow({super.key, required this.leading, required this.traling});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: !isLandscape ? 20 : 150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Text(traling, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}