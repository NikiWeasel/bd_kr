import 'package:flutter/material.dart';

import 'package:bd_kr/core/table_models/car_body_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class CarBodyTypeBottomSheet extends StatefulWidget {
  const CarBodyTypeBottomSheet({super.key, required this.carBodyType});

  final CarBodyType? carBodyType;

  @override
  State<CarBodyTypeBottomSheet> createState() => _CarBodyTypeBottomSheetState();
}

class _CarBodyTypeBottomSheetState extends State<CarBodyTypeBottomSheet> {
  late TextEditingController idController;
  late TextEditingController bodyTypeNameController;

  int enteredId = 0;
  String enteredBodyTypeName = '';

  late CarBodyType newCarBodyType;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newCarBodyType = CarBodyType(id: enteredId, name: enteredBodyTypeName);

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    bodyTypeNameController = TextEditingController();

    if (widget.carBodyType != null) {
      idController.text = widget.carBodyType!.id.toString();
      bodyTypeNameController.text = widget.carBodyType!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    bodyTypeNameController.dispose();
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
                  widget.carBodyType == null ? 'Добавить' : 'Изменить',
                  style: Theme
                      .of(context)
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
              controller: bodyTypeNameController,
              decoration: InputDecoration(
                label: const Text('Тип кузова'),
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
                enteredBodyTypeName = value!;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    if (widget.carBodyType == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newCarBodyType));
                    } else {
                      context.read<TableActionsBloc>().add(UpdateTableRow(
                          tableRow: newCarBodyType,
                          id: widget.carBodyType?.id));
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
