import 'package:flutter/material.dart';

import 'package:bd_kr/core/table_models/owner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class OwnerBottomSheet extends StatefulWidget {
  const OwnerBottomSheet({super.key, required this.owner});

  final Owner? owner;

  @override
  State<OwnerBottomSheet> createState() => _OwnerBottomSheetState();
}

class _OwnerBottomSheetState extends State<OwnerBottomSheet> {
  late TextEditingController idController;
  late TextEditingController ownerTypeController;
  late TextEditingController ownerInnController;

  int enteredId = 0;
  String? enteredOwnerType;
  String? enteredOwnerInn;

  late Owner newOwner;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newOwner = Owner(
      id: enteredId,
      ownerType: enteredOwnerType,
      inn: enteredOwnerInn,
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    ownerTypeController = TextEditingController();
    ownerInnController = TextEditingController();

    if (widget.owner != null) {
      idController.text = widget.owner!.id.toString();
      ownerTypeController.text = widget.owner!.ownerType ?? '';
      ownerInnController.text = widget.owner!.inn ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    ownerTypeController.dispose();
    ownerInnController.dispose();
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
                  widget.owner == null ? 'Добавить' : 'Изменить',
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
                      scale: 1.5, child: const Icon(Icons.close)),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 8),
            TextFormField(
              controller: ownerTypeController,
              decoration: InputDecoration(
                label: const Text('Тип владельца'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onSaved: (value) {
                enteredOwnerType = value;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: ownerInnController,
              decoration: InputDecoration(
                label: const Text('ИНН владельца'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onSaved: (value) {
                enteredOwnerInn = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_submit()) {
                  if (widget.owner == null) {
                    context
                        .read<TableActionsBloc>()
                        .add(AddTableRow(tableRow: newOwner));
                  } else {
                    context.read<TableActionsBloc>().add(UpdateTableRow(
                        tableRow: newOwner, id: widget.owner?.id));
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Подтвердить'),
            ),
          ],
        ),
      ),
    );
  }
}
