import 'package:bd_kr/core/view/window_buttons.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({super.key, required this.windowLabel});

  final String windowLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.onSecondary),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Stack(
            children: [
              MoveWindow(),
              Positioned(
                  top: 5,
                  left: 8,
                  child: IgnorePointer(
                      child: Text(
                    windowLabel,
                    style: Theme.of(context).textTheme.bodySmall,
                  )))
            ],
          )),
          const WindowButtons(),
        ],
      ),
    );
  }
}
