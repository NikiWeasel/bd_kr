import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableDialog extends StatelessWidget {
  const TableDialog(
      {super.key, required this.onDelete, required this.onUpdate});

  final void Function() onDelete;
  final void Function() onUpdate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выберите действие'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: onUpdate,
                child: Text(
                  'Редактировать',
                  style: Theme.of(context).textTheme.titleMedium!,
                )),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: onDelete,
                child: Text(
                  'Удалить',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                )),
          ),
        ],
      ),
    );
  }
}
