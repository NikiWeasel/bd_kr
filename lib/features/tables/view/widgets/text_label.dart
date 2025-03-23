import 'package:flutter/cupertino.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(label),
    );
  }
}
