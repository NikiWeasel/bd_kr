import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bd_kr/core/models/user.dart';
import 'package:bd_kr/core/services/sql_service.dart';

part 'user_auth_event.dart';

part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final SqlService sqlService;
  User currentUser = User.empty();

  UserAuthBloc(this.sqlService) : super(UserAuthInitial()) {
    on<AuthUser>((event, emit) async {
      emit(UserAuthLoading());
      try {
        var inputUser = event.inputUser;

        var users = await sqlService.loadUsers();

        var doesUserExist = sqlService.doesUserExist(users, inputUser);
        if (doesUserExist == null) {
          throw (Exception('Такого пользователя не существует'));
        }

        currentUser = doesUserExist;
        emit(UserAuthLoaded(user: currentUser));
      } catch (e) {
        print('e.toString()');
        emit(UserAuthError(errorMessage: e.toString()));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(UserAuthLoading());
      try {
        var inputUser = event.inputUser;

        sqlService.addTableRow(inputUser);

        currentUser = inputUser;
        emit(UserAuthLoaded(user: currentUser));
      } catch (e) {
        emit(UserAuthError(errorMessage: e.toString()));
      }
    });

    on<LogOutUser>((event, emit) async {
      emit(UserAuthLoading());
      try {
        currentUser = User.empty();
        emit(UserAuthLoaded(user: currentUser));
      } catch (e) {
        emit(UserAuthError(errorMessage: e.toString()));
      }
    });
  }
}
