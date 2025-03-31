import 'package:bd_kr/core/utils/format_date.dart';
import 'package:bd_kr/features/tables/view/widgets/table_dialog.dart';
import 'package:bd_kr/features/tables/view/widgets/text_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class MyDataTable extends StatefulWidget {
  const MyDataTable(
      {super.key,
      required this.table,
      required this.openBottomSheet,
      required this.tableName,
      required this.isReadOnly});

  final List<dynamic> table;
  final String tableName;
  final void Function(String tableName, dynamic rowToEdit) openBottomSheet;

  final bool isReadOnly;

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  late List<List<dynamic>> dataList;

  void fillDataList() {
    if (widget.table.isEmpty) return;

    dataList.clear();
    for (var e in widget.table) {
      dataList.add((e.toMap() as Map<String, dynamic>).values.toList());
    }
  }

  void showTableDialog(dynamic tableRow) {
    showDialog(
      context: context,
      builder: (context) => TableDialog(onDelete: () {
        Navigator.of(context).pop();
        context
            .read<TableActionsBloc>()
            .add(DeleteTableRow(tableRow: tableRow));
      }, onUpdate: () {
        Navigator.of(context).pop();
        widget.openBottomSheet(widget.tableName, tableRow);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    dataList = [];
    fillDataList();
  }

  @override
  Widget build(BuildContext context) {
    fillDataList();
    // print(dataList);

    if (widget.table.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Text(
                  'Таблица ${widget.tableName} пуста.',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 50),
                ),
              ],
            ),
          ],
        ),
      );
    }

    var tableMap =
        (widget.table[0].toMap() as Map<String, dynamic>).keys.toList();

    // print(dataList);
    return Table(
      border: TableBorder.all(color: Theme.of(context).colorScheme.onSurface),
      children: [
        TableRow(children: [for (var e in tableMap) TextLabel(label: e)]),
        for (int i = 0; i < dataList.length; i++)
          TableRow(children: [
            for (var cell in dataList[i])
              IgnorePointer(
                ignoring: widget.isReadOnly,
                child: InkWell(
                    onLongPress: () {
                      showTableDialog(widget.table[i]);
                    },
                    child: TextLabel(
                        label: cell is DateTime?
                            ? formatDate(cell)
                            : cell.toString())),
              )
          ])
      ],
    );
  }
}
