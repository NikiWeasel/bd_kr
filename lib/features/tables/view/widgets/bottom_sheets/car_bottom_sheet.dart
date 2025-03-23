import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/car.dart';

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
  late TextEditingController allWheelDriveController;
  late TextEditingController licensePlateController;
  late TextEditingController modelController;
  late TextEditingController steeringWheelController;
  late TextEditingController annualTaxController;
  late TextEditingController yearController;
  late TextEditingController engineNumberController;
  late TextEditingController stolenController;
  late TextEditingController returnDateController;
  late TextEditingController theftDateController;
  late TextEditingController bodyTypeIdController;
  late TextEditingController brandIdController;
  late TextEditingController ownerIdController;

  double? enteredEngineVolume;
  int? enteredColorId;
  double? enteredEnginePower;
  bool? enteredAllWheelDrive;
  String? enteredLicensePlate;
  String? enteredModel;
  String? enteredSteeringWheel;
  double? enteredAnnualTax;
  int? enteredYear;
  String? enteredEngineNumber;
  bool? enteredStolen;
  String? enteredReturnDate;
  String? enteredTheftDate;
  int? enteredBodyTypeId;
  int? enteredBrandId;
  int? enteredOwnerId;

  late Car newCar;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newCar = Car(
      id: widget.car!.id,
      engineVolume: enteredEngineVolume,
      colorId: enteredColorId,
      enginePower: enteredEnginePower,
      allWheelDrive: enteredAllWheelDrive,
      licensePlate: enteredLicensePlate,
      model: enteredModel,
      steeringWheel: enteredSteeringWheel,
      annualTax: enteredAnnualTax,
      year: enteredYear,
      engineNumber: enteredEngineNumber,
      stolen: enteredStolen,
      returnDate: enteredReturnDate,
      theftDate: enteredTheftDate,
      bodyTypeId: enteredBodyTypeId,
      brandId: enteredBrandId,
      ownerId: enteredOwnerId,
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    engineVolumeController = TextEditingController();
    colorIdController = TextEditingController();
    enginePowerController = TextEditingController();
    allWheelDriveController = TextEditingController();
    licensePlateController = TextEditingController();
    modelController = TextEditingController();
    steeringWheelController = TextEditingController();
    annualTaxController = TextEditingController();
    yearController = TextEditingController();
    engineNumberController = TextEditingController();
    stolenController = TextEditingController();
    returnDateController = TextEditingController();
    theftDateController = TextEditingController();
    bodyTypeIdController = TextEditingController();
    brandIdController = TextEditingController();
    ownerIdController = TextEditingController();

    if (widget.car != null) {
      enteredEngineVolume = widget.car!.engineVolume;
      enteredColorId = widget.car!.colorId;
      enteredEnginePower = widget.car!.enginePower;
      enteredAllWheelDrive = widget.car!.allWheelDrive;
      enteredLicensePlate = widget.car!.licensePlate;
      enteredModel = widget.car!.model;
      enteredSteeringWheel = widget.car!.steeringWheel;
      enteredAnnualTax = widget.car!.annualTax;
      enteredYear = widget.car!.year;
      enteredEngineNumber = widget.car!.engineNumber;
      enteredStolen = widget.car!.stolen;
      enteredReturnDate = widget.car!.returnDate;
      enteredTheftDate = widget.car!.theftDate;
      enteredBodyTypeId = widget.car!.bodyTypeId;
      enteredBrandId = widget.car!.brandId;
      enteredOwnerId = widget.car!.ownerId;

      engineVolumeController.text = widget.car!.engineVolume?.toString() ?? '';
      colorIdController.text = widget.car!.colorId?.toString() ?? '';
      enginePowerController.text = widget.car!.enginePower?.toString() ?? '';
      allWheelDriveController.text =
          widget.car!.allWheelDrive?.toString() ?? '';
      licensePlateController.text = widget.car!.licensePlate ?? '';
      modelController.text = widget.car!.model ?? '';
      steeringWheelController.text = widget.car!.steeringWheel ?? '';
      annualTaxController.text = widget.car!.annualTax?.toString() ?? '';
      yearController.text = widget.car!.year?.toString() ?? '';
      engineNumberController.text = widget.car!.engineNumber ?? '';
      stolenController.text = widget.car!.stolen?.toString() ?? '';
      returnDateController.text = widget.car!.returnDate ?? '';
      theftDateController.text = widget.car!.theftDate ?? '';
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
    allWheelDriveController.dispose();
    licensePlateController.dispose();
    modelController.dispose();
    steeringWheelController.dispose();
    annualTaxController.dispose();
    yearController.dispose();
    engineNumberController.dispose();
    stolenController.dispose();
    returnDateController.dispose();
    theftDateController.dispose();
    bodyTypeIdController.dispose();
    brandIdController.dispose();
    ownerIdController.dispose();
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
            _buildTextField('All Wheel Drive', allWheelDriveController),
            const SizedBox(height: 8),
            _buildTextField('License Plate', licensePlateController),
            const SizedBox(height: 8),
            _buildTextField('Model', modelController),
            const SizedBox(height: 8),
            _buildTextField('Steering Wheel', steeringWheelController),
            const SizedBox(height: 8),
            _buildTextField('Annual Tax', annualTaxController),
            const SizedBox(height: 8),
            _buildTextField('Year', yearController),
            const SizedBox(height: 8),
            _buildTextField('Engine Number', engineNumberController),
            const SizedBox(height: 8),
            _buildTextField('Stolen', stolenController),
            const SizedBox(height: 8),
            _buildTextField('Return Date', returnDateController),
            const SizedBox(height: 8),
            _buildTextField('Theft Date', theftDateController),
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
                    context
                        .read<TableActionsBloc>()
                        .add(UpdateTableRow(tableRow: newCar));
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
          case 'Engine Volume':
            enteredEngineVolume = double.tryParse(value ?? '');
            break;
          case 'Color ID':
            enteredColorId = int.tryParse(value!);
            break;
          case 'Engine Power':
            enteredEnginePower = double.tryParse(value ?? '');
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
        }
      },
    );
  }
}
