import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/car.dart';
import 'package:intl/intl.dart';

import 'package:bd_kr/core/utils/format_date.dart';

enum SteeringWheel { left, right }

class CarBottomSheet extends StatefulWidget {
  const CarBottomSheet({super.key, required this.car});

  final Car? car;

  @override
  State<CarBottomSheet> createState() => _CarBottomSheetState();
}

class _CarBottomSheetState extends State<CarBottomSheet> {
  late TextEditingController idController;
  late TextEditingController engineVolumeController;
  late TextEditingController colorIdController;
  late TextEditingController enginePowerController;
  late TextEditingController licensePlateController;
  late TextEditingController modelController;
  late TextEditingController annualTaxController;
  late TextEditingController yearController;
  late TextEditingController engineNumberController;
  late TextEditingController bodyTypeIdController;
  late TextEditingController brandIdController;
  late TextEditingController ownerIdController;

  SteeringWheel steeringWheelView = SteeringWheel.left;
  bool isStolen = false;
  bool isAllWheel = false;
  DateTime? pickedTheftDate;
  DateTime? pickedReturnDate;

  late int enteredId;

  double? enteredEngineVolume;
  int? enteredColorId;
  double? enteredEnginePower;
  String? enteredLicensePlate;
  String? enteredModel;
  double? enteredAnnualTax;
  int? enteredYear;
  String? enteredEngineNumber;
  int? enteredBodyTypeId;
  int? enteredBrandId;
  int? enteredOwnerId;

  late Car newCar;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<DateTime?> _showDatePicker() async {
    var firstDate = DateTime(1970, 1, 1);
    var lastDate = DateTime.now();

    var pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    return pickedDate;
  }

  void setPickedTheftDate() async {
    var val = await _showDatePicker();
    setState(() {
      pickedTheftDate = val;
    });
  }

  void setPickedReturnDate() async {
    var val = await _showDatePicker();
    setState(() {
      pickedReturnDate = val;
    });
  }

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newCar = Car(
      id: enteredId,
      engineVolume: enteredEngineVolume,
      colorId: enteredColorId,
      enginePower: enteredEnginePower,
      allWheelDrive: isAllWheel,
      licensePlate: enteredLicensePlate,
      model: enteredModel,
      steeringWheel: steeringWheelView == SteeringWheel.left ? 'Left' : 'Right',
      annualTax: enteredAnnualTax,
      year: enteredYear,
      engineNumber: enteredEngineNumber,
      stolen: isStolen,
      returnDate: pickedReturnDate,
      theftDate: pickedTheftDate,
      bodyTypeId: enteredBodyTypeId,
      brandId: enteredBrandId,
      ownerId: enteredOwnerId,
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    engineVolumeController = TextEditingController();
    colorIdController = TextEditingController();
    enginePowerController = TextEditingController();
    licensePlateController = TextEditingController();
    modelController = TextEditingController();
    annualTaxController = TextEditingController();
    yearController = TextEditingController();
    engineNumberController = TextEditingController();
    bodyTypeIdController = TextEditingController();
    brandIdController = TextEditingController();
    ownerIdController = TextEditingController();

    if (widget.car != null) {
      enteredId = widget.car!.id;
      enteredEngineVolume = widget.car!.engineVolume;
      enteredColorId = widget.car!.colorId;
      enteredEnginePower = widget.car!.enginePower;
      enteredLicensePlate = widget.car!.licensePlate;
      enteredModel = widget.car!.model;
      enteredAnnualTax = widget.car!.annualTax;
      enteredYear = widget.car!.year;
      enteredEngineNumber = widget.car!.engineNumber;

      enteredBodyTypeId = widget.car!.bodyTypeId;
      enteredBrandId = widget.car!.brandId;
      enteredOwnerId = widget.car!.ownerId;

      steeringWheelView = widget.car!.steeringWheel == 'Left'
          ? SteeringWheel.left
          : SteeringWheel.right;
      pickedTheftDate = widget.car!.theftDate;
      pickedReturnDate = widget.car!.returnDate;
      isStolen = widget.car!.stolen!;
      isAllWheel = widget.car!.allWheelDrive!;

      idController.text = widget.car!.id.toString();
      engineVolumeController.text = widget.car!.engineVolume?.toString() ?? '';
      colorIdController.text = widget.car!.colorId?.toString() ?? '';
      enginePowerController.text = widget.car!.enginePower?.toString() ?? '';

      licensePlateController.text = widget.car!.licensePlate ?? '';
      modelController.text = widget.car!.model ?? '';
      annualTaxController.text = widget.car!.annualTax?.toString() ?? '';
      yearController.text = widget.car!.year?.toString() ?? '';
      engineNumberController.text = widget.car!.engineNumber ?? '';
      bodyTypeIdController.text = widget.car!.bodyTypeId?.toString() ?? '';
      brandIdController.text = widget.car!.brandId?.toString() ?? '';
      ownerIdController.text = widget.car!.ownerId?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    engineVolumeController.dispose();
    colorIdController.dispose();
    enginePowerController.dispose();
    licensePlateController.dispose();
    modelController.dispose();
    annualTaxController.dispose();
    yearController.dispose();
    engineNumberController.dispose();
    bodyTypeIdController.dispose();
    brandIdController.dispose();
    ownerIdController.dispose();
    idController.dispose();
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
                  widget.car == null ? 'Добавить' : 'Изменить',
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
            _buildTextField('Engine Volume', engineVolumeController),
            const SizedBox(height: 8),
            _buildTextField('Color ID', colorIdController),
            const SizedBox(height: 8),
            _buildTextField('Engine Power', enginePowerController),
            const SizedBox(height: 8),
            ListTile(
              leading: Checkbox(
                onChanged: (value) {
                  setState(() {
                    isStolen = !isStolen;
                  });
                },
                value: isStolen,
              ),
              onTap: () {
                setState(() {
                  isStolen = !isStolen;
                });
              },
              title: const Text('Stolen'),
            ),
            const SizedBox(height: 8),
            _buildTextField('License Plate', licensePlateController),
            const SizedBox(height: 8),
            _buildTextField('Model', modelController),
            const SizedBox(height: 8),
            const Text('Steering Wheel'),
            SegmentedButton(
              segments: const <ButtonSegment<SteeringWheel>>[
                ButtonSegment<SteeringWheel>(
                  value: SteeringWheel.left,
                  label: Text('Left'),
                  icon: Icon(Icons.chevron_left),
                ),
                ButtonSegment<SteeringWheel>(
                  value: SteeringWheel.right,
                  label: Text('Right'),
                  icon: Icon(Icons.chevron_right),
                ),
              ],
              selected: <SteeringWheel>{steeringWheelView},
              onSelectionChanged: (Set<SteeringWheel> newSelection) {
                setState(() {
                  steeringWheelView = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 8),
            _buildTextField('Annual Tax', annualTaxController),
            const SizedBox(height: 8),
            _buildTextField('Year', yearController),
            const SizedBox(height: 8),
            _buildTextField('Engine Number', engineNumberController),
            const SizedBox(height: 8),
            ListTile(
              leading: Checkbox(
                onChanged: (value) {
                  setState(() {
                    isAllWheel = !isAllWheel;
                  });
                },
                value: isAllWheel,
              ),
              title: const Text('All wheel drive'),
              onTap: () {
                setState(() {
                  isAllWheel = !isAllWheel;
                });
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Return date:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton.icon(
                  onPressed: setPickedReturnDate,
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: Text(formatDate(pickedReturnDate)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Theft date:',
                    style: Theme.of(context).textTheme.bodyLarge),
                TextButton.icon(
                  onPressed: setPickedTheftDate,
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: Text(formatDate(pickedTheftDate)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildTextField('Body Type ID', bodyTypeIdController),
            const SizedBox(height: 8),
            _buildTextField('Brand ID', brandIdController),
            const SizedBox(height: 8),
            _buildTextField('Owner ID', ownerIdController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_submit()) {
                  if (widget.car == null) {
                    context
                        .read<TableActionsBloc>()
                        .add(AddTableRow(tableRow: newCar));
                  } else {
                    context.read<TableActionsBloc>().add(
                        UpdateTableRow(tableRow: newCar, id: widget.car?.id));
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
      readOnly: (widget.car != null && label == 'ID'),
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
            enteredId = int.tryParse(value!)!;
            break;
          case 'Engine Volume':
            enteredEngineVolume = double.tryParse(value ?? '');
            break;
          case 'Color ID':
            enteredColorId = int.tryParse(value!);
            break;
          case 'Annual Tax':
            enteredAnnualTax = double.tryParse(value!);
            break;
          case 'Engine Power':
            enteredEnginePower = double.tryParse(value ?? '');
            break;
          case 'Engine Number':
            enteredEngineNumber = value;
            break;
          case 'License Plate':
            enteredLicensePlate = value;
            break;
          case 'Model':
            enteredModel = value;
            break;
          case 'Year':
            enteredYear = int.tryParse(value ?? '');
            break;
          case 'Body Type ID':
            enteredBodyTypeId = int.tryParse(value ?? '');
            break;
          case 'Brand ID':
            enteredBrandId = int.tryParse(value ?? '');
            break;
          case 'Owner ID':
            enteredOwnerId = int.tryParse(value ?? '');
            break;
        }
      },
    );
  }
}
