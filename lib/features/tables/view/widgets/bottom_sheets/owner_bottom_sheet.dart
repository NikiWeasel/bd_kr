import 'package:flutter/material.dart';

import 'package:bd_kr/core/table_models/owner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

enum OwnerType { legal, phisical }

class OwnerBottomSheet extends StatefulWidget {
  const OwnerBottomSheet({super.key, required this.owner});

  final Owner? owner;

  @override
  State<OwnerBottomSheet> createState() => _OwnerBottomSheetState();
}

class _OwnerBottomSheetState extends State<OwnerBottomSheet> {
  late TextEditingController idController;
  late TextEditingController ownerInnController;

  OwnerType ownerTypeView = OwnerType.phisical;

  int enteredId = 0;
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
      ownerType: ownerTypeView == OwnerType.legal ? 'legal' : 'phisical',
      inn: enteredOwnerInn,
    );

    print(ownerTypeView == OwnerType.legal ? 'legal' : 'phisical');
    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    ownerInnController = TextEditingController();

    if (widget.owner != null) {
      idController.text = widget.owner!.id.toString();

      ownerTypeView = widget.owner!.ownerType == 'legal'
          ? OwnerType.legal
          : OwnerType.phisical;
      ownerInnController.text = widget.owner!.inn ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
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
              readOnly: widget.owner != null,
              controller: idController,
              decoration: InputDecoration(
                label: const Text('ID'),
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
            const Text('OwnerType'),
            SegmentedButton(
              segments: const <ButtonSegment<OwnerType>>[
                ButtonSegment<OwnerType>(
                  value: OwnerType.legal,
                  label: Text('legal'),
                  icon: Icon(Icons.chevron_left),
                ),
                ButtonSegment<OwnerType>(
                  value: OwnerType.phisical,
                  label: Text('phisical'),
                  icon: Icon(Icons.chevron_right),
                ),
              ],
              selected: <OwnerType>{ownerTypeView},
              onSelectionChanged: (Set<OwnerType> newSelection) {
                setState(() {
                  ownerTypeView = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: ownerInnController,
              decoration: InputDecoration(
                label: const Text('INN'),
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
