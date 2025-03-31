import 'dart:ffi' as ffi;

import 'package:bd_kr/core/bloc/local_tables_bloc/local_tables_bloc.dart';
import 'package:bd_kr/core/services/sql_service.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bd_kr/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';
import 'package:bd_kr/core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:intl/date_symbol_data_local.dart';

// ffi.DynamicLibrary _openSqliteUnderWindows() {
//   return ffi.DynamicLibrary.open('sqlite3.dll');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru', null);

  SqlService sqlService = SqlService();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LocalTablesBloc(sqlService),
      ),
      BlocProvider(
        create: (context) => TableActionsBloc(sqlService),
      ),
      BlocProvider(
        create: (context) => UserAuthBloc(sqlService),
      ),
    ],
    child: BlocProvider(
      create: (context) => TableActionsBloc(sqlService),
      child: const MaterialApp(home: App()),
    ),
  ));

  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = const Size(400, 300);
    win.alignment = Alignment.center;
    win.show();
  });
}
