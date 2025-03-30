import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/inspection.dart';
import 'package:intl/intl.dart';

import 'package:bd_kr/core/utils/format_date.dart';

class InspectionBottomSheet extends StatefulWidget {
  const InspectionBottomSheet({super.key, required this.inspection});

  final Inspection? inspection;

  @override
  State<InspectionBottomSheet> createState() => _InspectionBottomSheetState();
}

class _InspectionBottomSheetState extends State<InspectionBottomSheet> {
  late TextEditingController idController;
  late TextEditingController inspectorNameController;
  late TextEditingController failureReasonsController;
  late TextEditingController mileageController;
  late TextEditingController inspectionFeeController;
  late TextEditingController stickerFeeController;
  late TextEditingController carIdController;

  bool didPass = false;
  DateTime? pickedDate;

  late int enteredId;
  String? enteredInspectorName;
  String? enteredFailureReasons;
  int? enteredMileage;
  double? enteredInspectionFee;
  double? enteredStickerFee;
  int? enteredCarId;

  late Inspection newInspection;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<DateTime?> _showDatePicker() async {
    var firstDate = DateTime(1970, 1, 1);
    var lastDate = DateTime.now();

    var pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    return pickedDate;
  }

  void setPickedDate() async {
    var val = await _showDatePicker();
    setState(() {
      pickedDate = val;
    });
  }

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newInspection = Inspection(
      id: enteredId,
      // Assuming the ID is required and should default to 0 if null
      inspectorName: enteredInspectorName,
      inspectionDate: pickedDate,
      failureReasons: enteredFailureReasons,
      passed: didPass,
      mileage: enteredMileage,
      inspectionFee: enteredInspectionFee,
      signFee: enteredStickerFee,
      carId: enteredCarId,
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    inspectorNameController = TextEditingController();
    failureReasonsController = TextEditingController();
    mileageController = TextEditingController();
    inspectionFeeController = TextEditingController();
    stickerFeeController = TextEditingController();
    carIdController = TextEditingController();

    if (widget.inspection != null) {
      enteredId = widget.inspection!.id;
      enteredInspectorName = widget.inspection!.inspectorName;
      enteredFailureReasons = widget.inspection!.failureReasons;
      enteredMileage = widget.inspection!.mileage;
      enteredInspectionFee = widget.inspection!.inspectionFee;
      enteredStickerFee = widget.inspection!.signFee;
      enteredCarId = widget.inspection!.carId;

      pickedDate = widget.inspection!.inspectionDate;
      didPass = widget.inspection!.passed ?? false;
      idController.text = widget.inspection!.id.toString();
      inspectorNameController.text = widget.inspection!.inspectorName ?? '';
      failureReasonsController.text = widget.inspection!.failureReasons ?? '';
      mileageController.text = widget.inspection!.mileage?.toString() ?? '';
      inspectionFeeController.text =
          widget.inspection!.inspectionFee?.toString() ?? '';
      stickerFeeController.text = widget.inspection!.signFee?.toString() ?? '';
      carIdController.text = widget.inspection!.carId?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    inspectorNameController.dispose();
    failureReasonsController.dispose();
    mileageController.dispose();
    inspectionFeeController.dispose();
    stickerFeeController.dispose();
    carIdController.dispose();
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
                  widget.inspection == null ? 'Добавить' : 'Изменить',
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
                        scale: 1.5, child: const Icon(Icons.close))),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('ID', idController),
            const SizedBox(height: 8),
            _buildTextField('Inspector Name', inspectorNameController),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Date:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton.icon(
                  onPressed: setPickedDate,
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: Text(formatDate(pickedDate)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildTextField('Failure Reasons', failureReasonsController),
            const SizedBox(height: 8),
            ListTile(
              leading: Checkbox(
                onChanged: (value) {
                  setState(() {
                    didPass = !didPass;
                  });
                },
                value: didPass,
              ),
              onTap: () {
                setState(() {
                  didPass = !didPass;
                });
              },
              title: const Text('Passed'),
            ),
            const SizedBox(height: 8),
            _buildTextField('Mileage', mileageController),
            const SizedBox(height: 8),
            _buildTextField('Inspection Fee', inspectionFeeController),
            const SizedBox(height: 8),
            _buildTextField('Sticker Fee', stickerFeeController),
            const SizedBox(height: 8),
            _buildTextField('Car ID', carIdController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_submit()) {
                  if (widget.inspection == null) {
                    context
                        .read<TableActionsBloc>()
                        .add(AddTableRow(tableRow: newInspection));
                  } else {
                    context.read<TableActionsBloc>().add(UpdateTableRow(
                        tableRow: newInspection, id: widget.inspection?.id));
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
            enteredId = int.tryParse(value ?? '')!;
            break;
          case 'Inspector Name':
            enteredInspectorName = value;
            break;
          case 'Failure Reasons':
            enteredFailureReasons = value;
            break;
          case 'Mileage':
            enteredMileage = int.tryParse(value ?? '');
            break;
          case 'Inspection Fee':
            enteredInspectionFee = double.tryParse(value ?? '');
            break;
          case 'Sticker Fee':
            enteredStickerFee = double.tryParse(value ?? '');
            break;
          case 'Car ID':
            enteredCarId = int.tryParse(value ?? '');
            break;
        }
      },
    );
  }
}
