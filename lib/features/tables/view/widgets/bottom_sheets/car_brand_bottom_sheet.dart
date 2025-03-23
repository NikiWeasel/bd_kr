import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bd_kr/core/table_models/car_brand.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class CarBrandBottomSheet extends StatefulWidget {
  const CarBrandBottomSheet({super.key, required this.carBrand});

  final CarBrand? carBrand;

  @override
  State<CarBrandBottomSheet> createState() => _CarBrandBottomSheetState();
}

class _CarBrandBottomSheetState extends State<CarBrandBottomSheet> {
  late TextEditingController idController;
  late TextEditingController nameController;

  int enteredId = 0;
  String enteredName = '';

  late CarBrand newCarBrand;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newCarBrand = CarBrand(id: enteredId, name: enteredName);

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    nameController = TextEditingController();

    if (widget.carBrand != null) {
      idController.text = widget.carBrand!.id.toString();
      nameController.text = widget.carBrand!.name;
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
                  widget.carBrand == null ? 'Добавить' : 'Изменить',
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
                    if (widget.carBrand == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newCarBrand));
                    } else {
                      context
                          .read<TableActionsBloc>()
                          .add(UpdateTableRow(tableRow: newCarBrand));
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
