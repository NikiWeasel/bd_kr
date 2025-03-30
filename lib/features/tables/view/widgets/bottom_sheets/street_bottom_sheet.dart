import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/street.dart';

class StreetBottomSheet extends StatefulWidget {
  const StreetBottomSheet({super.key, required this.street});

  final Street? street;

  @override
  State<StreetBottomSheet> createState() => _StreetBottomSheetState();
}

class _StreetBottomSheetState extends State<StreetBottomSheet> {
  late TextEditingController idController;
  late TextEditingController streetNameController;

  int enteredId = 0;
  String enteredStreetName = '';

  late Street newStreet;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newStreet = Street(id: enteredId, name: enteredStreetName);

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    streetNameController = TextEditingController();

    if (widget.street != null) {
      idController.text = widget.street!.id.toString();
      streetNameController.text = widget.street!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    streetNameController.dispose();
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
                  widget.street == null ? 'Добавить' : 'Изменить',
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
              readOnly: widget.street != null,
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
              controller: streetNameController,
              decoration: InputDecoration(
                label: const Text('Название улицы'),
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
                enteredStreetName = value!;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    if (widget.street == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newStreet));
                    } else {
                      context.read<TableActionsBloc>().add(UpdateTableRow(
                          tableRow: newStreet, id: widget.street?.id));
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
