import 'package:bd_kr/core/models/search_query.dart';
import 'package:bd_kr/core/utils/snackbar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  late dynamic selectedColumn;
  String? selectedType;
  String enteredString = '';

  @override
  void initState() {
    super.initState();
    tableQTypesList = List.from(widget.tableQTypesDropdownMenuEntryList);
    selectedColumn = widget.tableColumnsDropdownMenuEntryList.first.value;

    selectedType =
        tableQTypesList.isNotEmpty ? tableQTypesList.first.value : null;
  }

  @override
  Widget build(BuildContext context) {
    void changeTypes() {
      setState(() {
        selectedType = null;
        if (selectedColumn is String) {
          tableQTypesList = List.from(tableQTypesList.sublist(5, 7));
        } else {
          tableQTypesList = List.from(widget.tableQTypesDropdownMenuEntryList);
        }
      });
    }

    void onChange() {
      final sq = SearchQuery(
          searchColumn: selectedColumn,
          searchType: selectedType!,
          searchString: enteredString);

      if (enteredString.isEmpty || selectedType == null) {
        return;
      }
      widget.onSaveQuary(widget.index, sq);
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
                    width: 162,
                    dropdownMenuEntries:
                        widget.tableColumnsDropdownMenuEntryList,
                    initialSelection: widget
                            .tableColumnsDropdownMenuEntryList.isNotEmpty
                        ? widget.tableColumnsDropdownMenuEntryList.first.value
                        : null,
                    onSelected: (value) {
                      if (value == null) return;
                      selectedColumn = value;

                      print('ONTAP');
                      changeTypes();
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
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Значение',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onChanged: (value) {
            enteredString = value;
            onChange();
          },
        ),
      ],
    );
  }
}
