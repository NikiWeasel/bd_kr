import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/table_models/owner_info.dart';

class OwnerInfoBottomSheet extends StatefulWidget {
  const OwnerInfoBottomSheet({super.key, required this.ownerInfo});

  final OwnerInfo? ownerInfo;

  @override
  State<OwnerInfoBottomSheet> createState() => _OwnerInfoBottomSheetState();
}

class _OwnerInfoBottomSheetState extends State<OwnerInfoBottomSheet> {
  late TextEditingController ownerNameController;
  late TextEditingController innController;
  late TextEditingController cityIdController;
  late TextEditingController districtIdController;
  late TextEditingController streetIdController;
  late TextEditingController houseController;
  late TextEditingController apartmentController;
  late TextEditingController organizationHeadController;

  String? enteredOwnerName;
  String? enteredInn;
  int? enteredCityId;
  int? enteredDistrictId;
  int? enteredStreetId;
  String? enteredHouse;
  String? enteredApartment;
  String? enteredOrganizationHead;

  late OwnerInfo newOwnerInfo;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    newOwnerInfo = OwnerInfo(
      ownerName: enteredOwnerName ?? '',
      inn: enteredInn ?? '',
      cityId: enteredCityId,
      districtId: enteredDistrictId,
      streetId: enteredStreetId,
      house: enteredHouse,
      apartment: enteredApartment,
      organizationHead: enteredOrganizationHead,
    );
    return true;
  }

  @override
  void initState() {
    super.initState();
    ownerNameController = TextEditingController();
    innController = TextEditingController();
    cityIdController = TextEditingController();
    districtIdController = TextEditingController();
    streetIdController = TextEditingController();
    houseController = TextEditingController();
    apartmentController = TextEditingController();
    organizationHeadController = TextEditingController();

    if (widget.ownerInfo != null) {
      enteredOwnerName = widget.ownerInfo!.ownerName;
      enteredInn = widget.ownerInfo!.inn;
      enteredCityId = widget.ownerInfo!.cityId;
      enteredDistrictId = widget.ownerInfo!.districtId;
      enteredStreetId = widget.ownerInfo!.streetId;
      enteredHouse = widget.ownerInfo!.house;
      enteredApartment = widget.ownerInfo!.apartment;
      enteredOrganizationHead = widget.ownerInfo!.organizationHead;

      // Заполнение контроллеров
      ownerNameController.text = widget.ownerInfo!.ownerName;
      innController.text = widget.ownerInfo!.inn;
      cityIdController.text = widget.ownerInfo!.cityId?.toString() ?? '';
      districtIdController.text =
          widget.ownerInfo!.districtId?.toString() ?? '';
      streetIdController.text = widget.ownerInfo!.streetId?.toString() ?? '';
      houseController.text = widget.ownerInfo!.house ?? '';
      apartmentController.text = widget.ownerInfo!.apartment ?? '';
      organizationHeadController.text =
          widget.ownerInfo!.organizationHead ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    ownerNameController.dispose();
    innController.dispose();
    cityIdController.dispose();
    districtIdController.dispose();
    streetIdController.dispose();
    houseController.dispose();
    apartmentController.dispose();
    organizationHeadController.dispose();
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
                  widget.ownerInfo == null ? 'Добавить' : 'Изменить',
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
            _buildTextField('Owner Name', ownerNameController),
            const SizedBox(height: 8),
            _buildTextField('INN', innController),
            const SizedBox(height: 8),
            _buildTextField('City ID', cityIdController),
            const SizedBox(height: 8),
            _buildTextField('District ID', districtIdController),
            const SizedBox(height: 8),
            _buildTextField('Street ID', streetIdController),
            const SizedBox(height: 8),
            _buildTextField('House', houseController),
            const SizedBox(height: 8),
            _buildTextField('Apartment', apartmentController),
            const SizedBox(height: 8),
            _buildTextField('Organization Head', organizationHeadController),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_submit()) {
                    if (widget.ownerInfo == null) {
                      context
                          .read<TableActionsBloc>()
                          .add(AddTableRow(tableRow: newOwnerInfo));
                    } else {
                      context.read<TableActionsBloc>().add(UpdateTableRow(
                          tableRow: newOwnerInfo, id: widget.ownerInfo?.inn));
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
          case 'Owner Name':
            enteredOwnerName = value;
            break;
          case 'INN':
            enteredInn = value;
            break;
          case 'City ID':
            enteredCityId = int.tryParse(value ?? '');
            break;
          case 'District ID':
            enteredDistrictId = int.tryParse(value ?? '');
            break;
          case 'Street ID':
            enteredStreetId = int.tryParse(value ?? '');
            break;
          case 'House':
            enteredHouse = value;
            break;
          case 'Apartment':
            enteredApartment = value;
            break;
          case 'Organization Head':
            enteredOrganizationHead = value;
            break;
        }
      },
    );
  }
}
