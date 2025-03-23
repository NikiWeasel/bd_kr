import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/phone.dart';

class PhoneBottomSheet extends StatefulWidget {
  const PhoneBottomSheet({super.key, required this.phone});

  final Phone? phone;

  @override
  State<PhoneBottomSheet> createState() => _PhoneBottomSheetState();
}

class _PhoneBottomSheetState extends State<PhoneBottomSheet> {
  late TextEditingController idController;
  late TextEditingController ownerIdController;
  late TextEditingController numberController;

  int? enteredId;
  int? enteredOwnerId;
  String? enteredNumber;

  late Phone newPhone;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newPhone = Phone(
      id: enteredId ?? 0, // Если enteredId null, по умолчанию 0
      ownerId: enteredOwnerId,
      number: enteredNumber,
    );
    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    ownerIdController = TextEditingController();
    numberController = TextEditingController();

    if (widget.phone != null) {
      enteredId = widget.phone!.id;
      enteredOwnerId = widget.phone!.ownerId;
      enteredNumber = widget.phone!.number;

      // Заполнение контроллеров
      idController.text = widget.phone!.id.toString();
      ownerIdController.text = widget.phone!.ownerId?.toString() ?? '';
      numberController.text = widget.phone!.number ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    ownerIdController.dispose();
    numberController.dispose();
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
                  widget.phone == null ? 'Добавить' : 'Изменить',
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
            _buildTextField('ID', idController),
            const SizedBox(height: 8),
            _buildTextField('Owner ID', ownerIdController),
            const SizedBox(height: 8),
            _buildTextField('Number', numberController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_submit()) {
                  if (widget.phone == null) {
                    context
                        .read<TableActionsBloc>()
                        .add(AddTableRow(tableRow: newPhone));
                  } else {
                    context
                        .read<TableActionsBloc>()
                        .add(UpdateTableRow(tableRow: newPhone));
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Подтвердить'),
            )
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextField(
      String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
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
        switch (label) {
          case 'ID':
            enteredId = int.tryParse(value ?? '');
            break;
          case 'Owner ID':
            enteredOwnerId = int.tryParse(value ?? '');
            break;
          case 'Number':
            enteredNumber = value;
            break;
        }
      },
    );
  }
}
