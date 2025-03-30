import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/car_color.dart';

class CarColorBottomSheet extends StatefulWidget {
  const CarColorBottomSheet({super.key, required this.carColor});

  final CarColor? carColor;

  @override
  State<CarColorBottomSheet> createState() => _CarColorBottomSheetState();
}

class _CarColorBottomSheetState extends State<CarColorBottomSheet> {
  late TextEditingController idController;
  late TextEditingController colorNameController;

  int enteredId = 0;
  String enteredColorName = '';

  late CarColor newCarColor;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newCarColor = CarColor(id: enteredId, name: enteredColorName);

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    colorNameController = TextEditingController();

    if (widget.carColor != null) {
      idController.text = widget.carColor!.id.toString();
      colorNameController.text = widget.carColor!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    colorNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  widget.carColor == null ? 'Добавить' : 'Изменить',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Transform.scale(
                        scale: 1.5, child: const Icon(Icons.close)))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              readOnly: widget.carColor != null,
              controller: idController,
              decoration: InputDecoration(
                label: const Text('id'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Незаполненное поле';
                }
                return null;
              },
              onSaved: (value) {
                enteredId = int.parse(value!);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: colorNameController,
              decoration: InputDecoration(
                label: const Text('Цвет'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Незаполненное поле';
                }
                return null;
              },
              onSaved: (value) {
                enteredColorName = value!;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    if (widget.carColor == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newCarColor));
                    } else {
                      context.read<TableActionsBloc>().add(UpdateTableRow(
                          tableRow: newCarColor, id: widget.carColor?.id));
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Подтвердить'))
          ],
        ),
      ),
    );
  }
}
