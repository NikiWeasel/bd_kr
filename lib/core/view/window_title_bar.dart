import 'package:bd_kr/core/view/window_buttons.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/user_auth_bloc/user_auth_bloc.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar(
      {super.key, required this.windowLabel, required this.showLogOutButton});

  final String windowLabel;
  final bool showLogOutButton;

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
          showLogOutButton
              ? IconButton(
                  onPressed: () {
                    context.read<UserAuthBloc>().add(LogOutUser());
                  },
                  icon: Transform.scale(
                      scale: 0.7, child: const Icon(Icons.logout)))
              : const SizedBox.shrink(),
          const WindowButtons(),
        ],
      ),
    );
  }
}
