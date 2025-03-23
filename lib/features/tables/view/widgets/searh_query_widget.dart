import 'package:bd_kr/core/models/search_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearhQueryWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    String selectedColumn = tableColumnsDropdownMenuEntryList.first.value;
    String selectedType = tableQTypesDropdownMenuEntryList.first.value;
    String enteredString = '';

    void onChange() {
      final sq = SearchQuery(
          searchColumn: selectedColumn,
          searchType: selectedType,
          searchString: enteredString);

      if (enteredString.isEmpty) return;
      onSaveQuary(index, sq);
    }

    return Column(
      children: [
        (index == 0)
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Text(
                    'Фильтр $index',
                    style: Theme.of(context).textTheme.titleMedium!,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        // print(index);
                        onDeleteQuary(index);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
        Row(
          children: [
            tableColumnsDropdownMenuEntryList.isNotEmpty
                ? DropdownMenu(
                    width: 162,
                    dropdownMenuEntries: tableColumnsDropdownMenuEntryList,
                    initialSelection:
                        tableColumnsDropdownMenuEntryList.isNotEmpty
                            ? tableColumnsDropdownMenuEntryList.first.value
                            : null,
                    onSelected: (value) {
                      if (value == null) return;
                      selectedColumn = value;
                    },
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 8,
            ),
            DropdownMenu(
              width: 130,
              dropdownMenuEntries: tableQTypesDropdownMenuEntryList,
              initialSelection: tableQTypesDropdownMenuEntryList.isNotEmpty
                  ? tableQTypesDropdownMenuEntryList.first.value
                  : null,
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
