import 'package:bd_kr/core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:bd_kr/core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:bd_kr/features/auth/view/auth_screen.dart';
import 'package:bd_kr/features/tables/view/tables_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/view/window_title_bar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthBloc, UserAuthState>(
      builder: (context, state) {
        if (state is UserAuthLoaded && !state.user.isEmpty()) {
          // print(state.user.isAdmin);
          appWindow.title = state.user.isAdmin
              ? 'База данных ГИБДД [Доступ: Администратор]'
              : 'База данных ГИБДД [Доступ: Пользователь]';

          return Column(
            children: [
              WindowTitleBar(
                windowLabel: state.user.isAdmin
                    ? 'База данных ГИБДД [Доступ: Администратор]'
                    : 'База данных ГИБДД [Доступ: Пользователь]',
              ),
              Expanded(
                child: TablesScreen(
                  isAdmin: state.user.isAdmin,
                ),
              ),
            ],
          );
        }
        return const Column(
          children: [
            WindowTitleBar(
              windowLabel: '',
            ),
            Expanded(child: AuthScreen()),
          ],
        );
      },
    );
  }
}
