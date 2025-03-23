import 'package:flutter/material.dart';

import 'package:bd_kr/core/table_models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class NoteBottomSheet extends StatefulWidget {
  const NoteBottomSheet({super.key, required this.note});

  final Note? note;

  @override
  State<NoteBottomSheet> createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet> {
  late TextEditingController idController;
  late TextEditingController carIdController;
  late TextEditingController contentController;

  int? enteredId;
  int? enteredCarId;
  String? enteredContent;

  late Note newNote;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newNote = Note(
      id: enteredId ?? 0,
      carId: enteredCarId,
      content: enteredContent,
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    carIdController = TextEditingController();
    contentController = TextEditingController();

    if (widget.note != null) {
      enteredId = widget.note!.id;
      enteredCarId = widget.note!.carId;
      enteredContent = widget.note!.content;

      idController.text = widget.note!.id.toString();
      carIdController.text = widget.note!.carId?.toString() ?? '';
      contentController.text = widget.note!.content ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    carIdController.dispose();
    contentController.dispose();
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
                  widget.note == null ? 'Добавить' : 'Изменить',
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
            _buildTextField('ID', idController),
            const SizedBox(height: 8),
            _buildTextField('Car ID', carIdController),
            const SizedBox(height: 8),
            _buildTextField('Content', contentController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_submit()) {
                  if (widget.note == null) {
                    context
                        .read<TableActionsBloc>()
                        .add(AddTableRow(tableRow: newNote));
                  } else {
                    context
                        .read<TableActionsBloc>()
                        .add(UpdateTableRow(tableRow: newNote));
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

  TextFormField _buildTextField(
    String label,
    TextEditingController controller,
  ) {
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
          case 'Car ID':
            enteredCarId = int.tryParse(value ?? '');
            break;
          case 'Content':
            enteredContent = value;
            break;
        }
      },
    );
  }
}
