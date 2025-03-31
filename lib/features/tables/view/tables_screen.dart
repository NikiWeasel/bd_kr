import 'package:bd_kr/core/models/search_query.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/car_body_type_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/car_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/car_brand_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/car_color_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/city_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/district_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/inspection_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/note_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/owner_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/owner_info_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/phone_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/bottom_sheets/street_bottom_sheet.dart';
import 'package:bd_kr/features/tables/view/widgets/data_table.dart';
import 'package:bd_kr/features/tables/view/widgets/searh_query_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/bloc/local_tables_bloc/local_tables_bloc.dart';
import 'package:bd_kr/core/utils/snackbar_utils.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key, required this.isAdmin});

  final bool isAdmin;

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  // ValueNotifier<String?> _selectedValueNotifier =
  //     ValueNotifier<DropdownMenuEntry?>(null);

  List<DropdownMenuEntry> tableDropdownMenuEntryList = [];
  List<DropdownMenuEntry> tableColumnsDropdownMenuEntryList = [];
  List<DropdownMenuEntry> tableQTypesDropdownMenuEntryList = const [
    DropdownMenuEntry(value: '=', label: '='),
    DropdownMenuEntry(value: '>', label: '>'),
    DropdownMenuEntry(value: '>=', label: '>='),
    DropdownMenuEntry(value: '<', label: '<'),
    DropdownMenuEntry(value: '<=', label: '<='),
    DropdownMenuEntry(value: 'Входит', label: 'Входит'),
    DropdownMenuEntry(value: 'Начинается с', label: 'Начинается с'),
  ];

  List<String> tableNames = [];
  Map<String, dynamic> tableColumnNames = {};
  List<dynamic> activeTable = [];
  String activeTableName = '';

  List<dynamic> activeSearchTable = [];

  List<SearchQuery> searchQueryList = [];

  // late int searchQueryCounter;

  // List<Widget> searchWidgets = [];

  fillTableDropdownMenuEntryList() {
    tableDropdownMenuEntryList.clear();

    for (var e in tableNames) {
      tableDropdownMenuEntryList.add(DropdownMenuEntry(value: e, label: e));
    }
  }

  void fillColumnsNames(List<dynamic> list) {
    if (list.isEmpty) return;
    // print('object');
    // for (var t in list) {
    //   print('t');
    //   print(t.stolen);
    //   // print(t.value);
    // }

    tableColumnNames = (list[0].toMap() as Map<String, dynamic>);
    // print(tableColumnNames);

    tableColumnsDropdownMenuEntryList.clear();
    for (var e in tableColumnNames.entries) {
      print(e.key);
      print(e.value.runtimeType);
      tableColumnsDropdownMenuEntryList.add(DropdownMenuEntry(
          value: (label: e.key.toString(), value: e.value),
          label: e.key.toString()));
    }
    // print('tableColumnNames');
    // print(tableColumnNames);
    // print(tableColumnsDropdownMenuEntryList);
  }

  void addSearchQuary() {
    setState(() {
      searchQueryList.add(
          SearchQuery(searchColumn: '', searchType: '=', searchString: ''));
    });
  }

  void onSaveQuary(int index, SearchQuery sq) {
    if (index >= searchQueryList.length) {
      searchQueryList.add(sq);
    } else {
      searchQueryList[index] = sq;
    }
  }

  void onDeleteQuary(int index) {
    // print(index);
    // print(searchQueryList);
    setState(() {
      searchQueryList.removeAt(index);
    });
  }

  void showSnackbar(String m) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Center(child: Text(m))));
  }

  @override
  void initState() {
    super.initState();
    searchQueryList = List.generate(
      1,
      (index) => SearchQuery(
          searchColumn: 'tableColumnNames.first',
          searchType: 'tableQTypesDropdownMenuEntryList.first.label',
          searchString: ''),
    );

    // searchQueryCounter = searchQueryList.length;
  }

  @override
  void dispose() {
    super.dispose();
    // _selectedValueNotifier.dispose();
  }

  void openBottomSheet(String tableName, dynamic rowToEdit) {
    switch (tableName) {
      case 'car_brands':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: CarBrandBottomSheet(
              carBrand: rowToEdit,
            ),
          ),
        );
        break;
      case 'districts':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: DistrictBottomSheet(
              district: rowToEdit,
            ),
          ),
        );
        break;
      case 'streets':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: StreetBottomSheet(
              street: rowToEdit,
            ),
          ),
        );
        break;
      case 'car_colors':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: CarColorBottomSheet(
              carColor: rowToEdit,
            ),
          ),
        );
        break;
      case 'cities':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: CityBottomSheet(
              city: rowToEdit,
            ),
          ),
        );
        break;
      case 'car_body_types':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: CarBodyTypeBottomSheet(
              carBodyType: rowToEdit,
            ),
          ),
        );
        break;
      case 'owners':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: OwnerBottomSheet(
              owner: rowToEdit,
            ),
          ),
        );
        break;
      case 'owner_info':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: OwnerInfoBottomSheet(
              ownerInfo: rowToEdit,
            ),
          ),
        );
        break;
      case 'phones':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: PhoneBottomSheet(
              phone: rowToEdit,
            ),
          ),
        );
        break;
      case 'cars':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: CarBottomSheet(
              car: rowToEdit,
            ),
          ),
        );
        break;
      case 'inspections':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: InspectionBottomSheet(
              inspection: rowToEdit,
            ),
          ),
        );
        break;
      case 'notes':
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: NoteBottomSheet(
              note: rowToEdit,
            ),
          ),
        );
        break;
      default:
        throw Exception('Unknown table name: $tableName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableActionsBloc, TableActionsState>(
      listener: (context, state) {
        // if (state is TableActionsLoading) {
        //   ScaffoldMessenger.of(context).clearSnackBars();
        //   showSnackBar(context, 'Загрузка...',
        //       duration: const Duration(seconds: 60));
        // }
        // print(state);

        if (state is TableActionsAdded) {
          ScaffoldMessenger.of(context).clearSnackBars();

          showSnackBar(context, 'Строка добавлена.');

          context.read<LocalTablesBloc>().add(AddLocalTableRow(
              tableName: activeTableName, value: state.tableRow));
        }
        if (state is TableActionsUpdated) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showSnackBar(context, 'Строка обновлена');

          context.read<LocalTablesBloc>().add(UpdateLocalTableRow(
                tableName: activeTableName,
                value: state.tableRow,
                id: state.id,
              ));
        }
        if (state is TableActionsDeleted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showSnackBar(context, 'Строка удалена.');

          context.read<LocalTablesBloc>().add(DeleteLocalTableRow(
              tableName: activeTableName, value: state.tableRow));
        }
        if (state is TableActionsError) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showSnackBar(context, 'Произошла ошибка: ${state.errorMessage}');
        }
      },
      child: BlocBuilder<LocalTablesBloc, LocalTablesState>(
        builder: (context, state) {
          // print(state);

          if (state is LocalTablesLoaded) {
            // print(state.allTables.parentTable);
            var allTablesMap = state.allTables.parentTable;
            fillTableDropdownMenuEntryList();
            tableNames = state.allTables.getTableNames();

            fillColumnsNames(activeTable);

            if (tableDropdownMenuEntryList.isEmpty) {
              context.read<LocalTablesBloc>().add(FetchLocalTablesData());
            }

            // print(activeTable);
            // print(allTablesMap);
            // print(tableColumnsDropdownMenuEntryList);
            // print(tableQTypesDropdownMenuEntryList);

            return Scaffold(
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Текущая таблица',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    DropdownMenu(
                                      width: 300,
                                      dropdownMenuEntries:
                                          tableDropdownMenuEntryList,
                                      initialSelection:
                                          tableDropdownMenuEntryList.isNotEmpty
                                              ? tableDropdownMenuEntryList.first
                                              : null,
                                      onSelected: (value) {
                                        if (value == null) return;

                                        setState(() {
                                          activeTable = allTablesMap[value]!;
                                          activeTableName = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'Поиск по таблице',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!,
                                    ),
                                    if (activeTable.isNotEmpty) ...[
                                      for (int i = 0;
                                          i < searchQueryList.length;
                                          i++) ...[
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        (tableColumnsDropdownMenuEntryList
                                                    .isEmpty ||
                                                tableQTypesDropdownMenuEntryList
                                                    .isEmpty)
                                            ? const SizedBox.shrink()
                                            : SearhQueryWidget(
                                                key: ValueKey(activeTableName +
                                                    i.toString()),
                                                index: i,
                                                onSaveQuary: onSaveQuary,
                                                tableColumnsDropdownMenuEntryList:
                                                    tableColumnsDropdownMenuEntryList,
                                                tableQTypesDropdownMenuEntryList:
                                                    tableQTypesDropdownMenuEntryList,
                                                onDeleteQuary: onDeleteQuary,
                                              ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface)),
                                            ))
                                      ],
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: IconButton(
                                              onPressed: () {
                                                if (activeTable.isEmpty) {
                                                  showSnackbar(
                                                      'Выбeрите таблицу');
                                                  return;
                                                }
                                                addSearchQuary();
                                              },
                                              icon: const Icon(Icons.add))),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: MyDataTable(
                        table: activeTable,
                        openBottomSheet: openBottomSheet,
                        tableName: activeTableName,
                        isReadOnly: !widget.isAdmin,
                      ),
                    )))
                  ],
                ),
                floatingActionButtonAnimator: null,
                floatingActionButton: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 32,
                                ),
                                FloatingActionButton(
                                  heroTag: 'search',
                                  onPressed: () {
                                    if (activeTable.isEmpty) return;
                                    // print(searchQueryList);

                                    if (searchQueryList.any(
                                          (element) =>
                                              element.searchString == '',
                                        ) ||
                                        searchQueryList.any(
                                          (element) =>
                                              element.searchColumn == '',
                                        )) {
                                      showSnackbar('Заполните поля поиска');
                                      return;
                                    }

                                    context.read<LocalTablesBloc>().add(
                                        SearchLocalTableRow(
                                            tableRow: activeTable[0],
                                            sqList: searchQueryList,
                                            tableName: activeTableName));
                                  },
                                  child: const Icon(Icons.search),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                FloatingActionButton(
                                  heroTag: 'reset',
                                  onPressed: () {
                                    context
                                        .read<LocalTablesBloc>()
                                        .add(FetchLocalTablesData());
                                    //
                                    // setState(() {
                                    //   if (!tableDropdownMenuEntryList.contains(
                                    //       _selectedValueNotifier.value)) {
                                    //     _selectedValueNotifier.value =
                                    //         tableDropdownMenuEntryList
                                    //             .first; // Если нет, устанавливаем первое значение
                                    //   }
                                    // });
                                  },
                                  child: const Icon(Icons.cached_sharp),
                                )
                              ],
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: widget.isAdmin
                          ? FloatingActionButton(
                              heroTag: 'add',
                              clipBehavior: Clip.none,
                              child: const Icon(Icons.add),
                              onPressed: () {
                                openBottomSheet(activeTableName, null);
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ));
          }
          if (state is LocalTablesError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage),
                    TextButton(
                        onPressed: () {
                          context
                              .read<LocalTablesBloc>()
                              .add(FetchLocalTablesData());
                        },
                        child: const Text('Обновить'))
                  ],
                ),
              ),
            );
          }
          // print(state);
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
