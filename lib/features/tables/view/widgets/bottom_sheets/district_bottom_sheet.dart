import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/district.dart';

class DistrictBottomSheet extends StatefulWidget {
  const DistrictBottomSheet({super.key, required this.district});

  final District? district;

  @override
  State<DistrictBottomSheet> createState() => _DistrictBottomSheetState();
}

class _DistrictBottomSheetState extends State<DistrictBottomSheet> {
  late TextEditingController idController;
  late TextEditingController nameController;

  int enteredId = 0;
  String enteredName = '';

  late District newDistrict;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newDistrict = District(id: enteredId, name: enteredName);
    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    nameController = TextEditingController();

    if (widget.district != null) {
      idController.text = widget.district!.id.toString();
      nameController.text = widget.district!.name;
    }
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    super.dispose();
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
                  widget.district == null ? 'Добавить' : 'Изменить',
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
            const SizedBox(height: 16),
            TextFormField(
              controller: idController,
              readOnly: widget.district != null,
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    if (widget.district == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newDistrict));
                    } else {
                      context.read<TableActionsBloc>().add(UpdateTableRow(
                          tableRow: newDistrict, id: widget.district?.id));
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
