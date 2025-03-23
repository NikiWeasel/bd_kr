import 'dart:convert';

import 'package:bd_kr/core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bd_kr/core/models/user.dart';

import 'package:bd_kr/core/bloc/table_actions_bloc/table_actions_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String userPhoneNumber = '';
  String userLogin = '';
  String userPassword = '';

  bool isVisible = true;

  bool isRegistration = false;

  bool isAdmin = false;

  late User inputUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _submit() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();

    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode(userPassword);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var hashedPassword = hmacSha256.convert(bytes).toString();

    inputUser = User(
        login: userLogin,
        phoneNumber: userPhoneNumber,
        isAdmin: isAdmin,
        password: hashedPassword);

    // print('inputUser.id');
    // print(inputUser.id);

    return true;
  }

  void toggleAuthMode() {
    setState(() {
      isRegistration = !isRegistration;
    });
  }

  void toggleAdmin() {
    setState(() {
      isAdmin = !isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAuthBloc, UserAuthState>(
      listener: (context, state) {
        if (state is UserAuthError) {
          print(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(child: Text(state.errorMessage))));
        }
      },
      child: Scaffold(
        body: Center(
          child: Card(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isRegistration ? 'Регистрация' : 'Вход',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 40),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (isRegistration) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          key: const ValueKey('number'),
                          decoration: InputDecoration(
                              label: const Text('Номер телефона'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Незаполненное поле';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userPhoneNumber = value!;
                          },
                        ),
                      ],
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        key: const ValueKey('login'),
                        decoration: InputDecoration(
                            label: const Text('Логин'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Незаполненное поле';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userLogin = value!;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            label: const Text('Пароль'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: isVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Незаполненное поле';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userPassword = value!;
                        },
                      ),
                      if (isRegistration) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        CheckboxListTile(
                            title: const Text('Администратор'),
                            value: isAdmin,
                            onChanged: (value) {
                              setState(() {
                                isAdmin = value ?? false;
                              });
                            }),
                      ],
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_submit()) {
                              if (isRegistration) {
                                context
                                    .read<UserAuthBloc>()
                                    .add(RegisterUser(inputUser: inputUser));
                              } else {
                                context
                                    .read<UserAuthBloc>()
                                    .add(AuthUser(inputUser: inputUser));
                              }
                              context
                                  .read<TableActionsBloc>()
                                  .add(FetchTablesData());
                            }
                          },
                          child: Text(
                              isRegistration ? 'Зарегистрироваться' : 'Войти')),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: toggleAuthMode,
                          child: Text(isRegistration
                              ? 'Уже есть аккаунт'
                              : 'Регистрация')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
