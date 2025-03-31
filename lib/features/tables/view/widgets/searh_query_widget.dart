import 'package:bd_kr/core/models/search_query.dart';
import 'package:bd_kr/core/utils/snackbar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearhQueryWidget extends StatefulWidget {
  const SearhQueryWidget(
      {super.key,
      required this.index,
      required this.onSaveQuary,
      required this.tableColumnsDropdownMenuEntryList,
      required this.tableQTypesDropdownMenuEntryList,
      required this.onDeleteQuary});

  final int index;
  final void Function(int index, SearchQuery sq) onSaveQuary;
  final void Function(int index) onDeleteQuary;

  final List<DropdownMenuEntry> tableColumnsDropdownMenuEntryList;
  final List<DropdownMenuEntry> tableQTypesDropdownMenuEntryList;

  @override
  State<SearhQueryWidget> createState() => _SearhQueryWidgetState();
}

class _SearhQueryWidgetState extends State<SearhQueryWidget> {
  late List<DropdownMenuEntry> tableQTypesList;
  late String selectedColumn;
  late dynamic selectedColumnValue;
  String selectedType = '';
  String enteredString = '';

  bool boolValue = false;

  // @override
  // void initState() {
  //   super.initState();
  //   tableQTypesList = List.from(widget.tableQTypesDropdownMenuEntryList);
  //   selectedColumn = widget.tableColumnsDropdownMenuEntryList.first.label;
  //   // print(selectedColumn[0].);
  //
  //   selectedType =
  //       tableQTypesList.isNotEmpty ? tableQTypesList.first.value : null;
  // }

  @override
  void initState() {
    super.initState();

    // Начинаем с полного списка операторов
    tableQTypesList = List.from(widget.tableQTypesDropdownMenuEntryList);

    // Безопасно устанавливаем начальные значения
    selectedColumn = widget.tableColumnsDropdownMenuEntryList.isNotEmpty
        ? widget.tableColumnsDropdownMenuEntryList.first.label
        : '';

    selectedColumnValue = widget.tableColumnsDropdownMenuEntryList.isNotEmpty
        ? widget.tableColumnsDropdownMenuEntryList.first.value
        : null;

    selectedType =
        tableQTypesList.isNotEmpty ? tableQTypesList.first.value : '';
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.tableColumnsDropdownMenuEntryList);

    void changeTypes() {
      setState(() {
        selectedType = '';
        if (selectedColumnValue is String) {
          print('str');

          tableQTypesList = List.from(widget.tableQTypesDropdownMenuEntryList);
          tableQTypesList = List.from(tableQTypesList.sublist(5, 7));
        } else {
          if (selectedColumnValue is bool) {
            print('bool');

            tableQTypesList =
                List.from(widget.tableQTypesDropdownMenuEntryList);
            tableQTypesList = List.from([tableQTypesList.first]);
          } else {
            print('hhhhhhhh');

            tableQTypesList =
                List.from(widget.tableQTypesDropdownMenuEntryList);
          }
        }
      });
    }

    void onChange() {
      if (enteredString.isEmpty) {
        return;
      }
      final sq = SearchQuery(
          searchColumn: selectedColumn,
          searchType: selectedType,
          searchString: selectedColumnValue is! bool
              ? enteredString
              : (boolValue ? '1' : '0'));

      print('save qs');
      // print(sq.searchColumn);
      // print(sq.searchType);
      // print(sq.searchString);
      widget.onSaveQuary(widget.index, sq);
    }

    if (widget.tableColumnsDropdownMenuEntryList.isEmpty ||
        widget.tableQTypesDropdownMenuEntryList.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        (widget.index == 0)
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Text(
                    'Фильтр ${widget.index}',
                    style: Theme.of(context).textTheme.titleMedium!,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        // print(index);
                        widget.onDeleteQuary(widget.index);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
        Row(
          children: [
            widget.tableColumnsDropdownMenuEntryList.isNotEmpty
                ? DropdownMenu(
                    // key: ValueKey('${widget.index}'),
                    width: 162,
                    dropdownMenuEntries:
                        widget.tableColumnsDropdownMenuEntryList,
                    initialSelection: widget
                            .tableColumnsDropdownMenuEntryList.isNotEmpty
                        ? widget.tableColumnsDropdownMenuEntryList.first.value
                        : null,
                    onSelected: (value) {
                      if (value == null) return;
                      // print(value);
                      // print(tableQTypesList[0].label);
                      // print(tableQTypesList[0].value);

                      try {
                        final selectedEntry =
                            widget.tableColumnsDropdownMenuEntryList.firstWhere(
                                (entry) => (entry.label == value!.label));

                        selectedColumn = selectedEntry.label;
                        selectedColumnValue = selectedEntry.value.value;
                        print(selectedColumn);

                        print(selectedColumnValue);
                        print('ONTAP');

                        changeTypes();
                      } catch (e) {
                        debugPrint('Error in changeTypes: $e');
                        tableQTypesList =
                            List.from(widget.tableQTypesDropdownMenuEntryList);
                      }
                    },
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 8,
            ),
            DropdownMenu(
              key: ValueKey(tableQTypesList.length),
              width: 130,
              dropdownMenuEntries: tableQTypesList,
              // initialSelection: tableQTypesList.isNotEmpty
              //     ? tableQTypesList.first.value
              //     : null,
              onSelected: (value) {
                if (value == null) return;
                selectedType = value;
              },
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        (selectedColumnValue is! bool)
            ? TextFormField(
                decoration: InputDecoration(
                  labelText: 'Значение',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                inputFormatters: (selectedColumnValue is int ||
                        selectedColumnValue is double)
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                      ]
                    : [],
                onChanged: (value) {
                  enteredString = value;
                  onChange();
                },
              )
            : CheckboxListTile(
                value: boolValue,
                title: const Text('Значение'),
                onChanged: (value) {
                  setState(() {
                    if (value == null) return;
                    boolValue = value;
                    enteredString = boolValue ? '1' : '0';
                    onChange();
                  });
                }),
      ],
    );
  }
}
