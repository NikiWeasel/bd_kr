import 'package:flutter/material.dart';

void showSnackBar(
  context,
  String message, {
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.down,
      duration: duration ?? const Duration(milliseconds: 1500),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      // behavior: SnackBarBehavior.floating,
      behavior: SnackBarBehavior.fixed,

      content: Center(
        child: Text('$message',
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white)),
      ),
    ),
  );
}
