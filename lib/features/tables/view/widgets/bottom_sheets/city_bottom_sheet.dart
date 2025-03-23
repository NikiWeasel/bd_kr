import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/table_models/city.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class CityBottomSheet extends StatefulWidget {
  const CityBottomSheet({super.key, required this.city});

  final City? city;

  @override
  State<CityBottomSheet> createState() => _CityBottomSheetState();
}

class _CityBottomSheetState extends State<CityBottomSheet> {
  late TextEditingController idController;
  late TextEditingController nameController;

  int enteredId = 0;
  String enteredName = '';

  late City newCity;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newCity = City(id: enteredId, name: enteredName);

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    nameController = TextEditingController();

    if (widget.city != null) {
      idController.text = widget.city!.id.toString();
      nameController.text = widget.city!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    nameController.dispose();
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
                  widget.city == null ? 'Добавить' : 'Изменить',
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
              controller: nameController,
              decoration: InputDecoration(
                label: const Text('Название'),
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
                enteredName = value!;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    if (widget.city == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newCity));
                    } else {
                      context
                          .read<TableActionsBloc>()
                          .add(UpdateTableRow(
                          tableRow: newCity, id: widget.city?.id));
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
