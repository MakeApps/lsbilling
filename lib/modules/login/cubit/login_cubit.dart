import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formz/formz.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/internet/internet.dart';
import 'package:local_shout_billing/models/login_model.dart';
import 'package:local_shout_billing/network/repositories/authentication.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final _storage = const FlutterSecureStorage();
  LogInCubit() : super(const LogInState());
  final NetworkCheck _networkCheck = NetworkCheck();

  void emailChanged(String emailvalue) {
    final email = Email.dirty(emailvalue);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String passwordValue) {
    final password = Password.dirty(passwordValue);
    emit(
      state.copyWith(
        email: state.email,
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void resetErrors() {
    emit(state.copyWith(
      email: const Email.pure(),
      password: const Password.pure(),
    ));
  }

  Future<dynamic> submitLoginForm(BuildContext context) async {
    if (state.status.isValidated) {
      emit(
        state.copyWith(status: FormzStatus.submissionInProgress),
      );
    }

    // Check internet connection before proceeding
    bool isConnected = await _networkCheck.isInternetConnected();
    if (!isConnected) {
      emit(state.copyWith(
        errorMessage:
            "No Internet Connection, Please check your Internet Connection",
        status: FormzStatus.submissionFailure,
      ));
      return;
    }

    try {
      Map<String, Object> jsonData = {
        "formData": jsonEncode(
            {'email': state.email.value, 'password': state.password.value})
      };
      final result = await AuthenticationRepo().submitLoginForm(jsonData);

      if (result != null && result.containsKey('login_limit_reached')) {
        emit(
          state.copyWith(
            errorMessage: result['login_limit_reached'],
            status: FormzStatus.submissionFailure,
          ),
        );

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              title: const Text(
                "Login Limit Reached",
                style: TextStyle(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: FontWeight.w600),
              ),
              content: const Text(
                "Your account has reached the maximum number of allowed logins. Please extend your plan.",
                style: TextStyle(
                    fontSize: 13,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                        fontSize: 13,
                        color: blueColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          },
        );
        return;
      }
      //  CONDITION 2: SAME USER ALREADY LOGGED IN ON ANOTHER DEVICE
      if (result != null && result.containsKey('already_logged')) {
        emit(
          state.copyWith(
            errorMessage: result['already_logged'],
            status: FormzStatus.submissionFailure,
          ),
        );

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              title: const Text(
                "Already Logged In",
                style: TextStyle(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: FontWeight.w600),
              ),
              content: const Text(
                "You are already logged in on another device. Please logout from other device to continue.",
                style: TextStyle(
                    fontSize: 13,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    backgroundColor: successColor,
                    foregroundColor: whiteColor,
                  ),
                  child: const Text(
                    'Cancel',
                  ),
                ),
              ],
            );
          },
        );
        return;
      }

      if (result != null && result.containsKey('login_subcription')) {
        String subscriptionDateStr = result['login_subcription'];

        if (subscriptionDateStr == 'Expired') {
          emit(
            state.copyWith(
              errorMessage: "Login failed...",
              status: FormzStatus.submissionFailure,
            ),
          );
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                title: const Text(
                  'Subscription Ended',
                  style: TextStyle(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.w600),
                ),
                content: const Text(
                  'Unable to login, your subscription has ended.',
                  style: TextStyle(
                      fontSize: 13,
                      color: blackColor,
                      fontWeight: FontWeight.w500),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      backgroundColor: successColor,
                      foregroundColor: whiteColor,
                    ),
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          DateTime subscriptionDate = DateTime.parse(subscriptionDateStr);
          DateTime today = DateTime.now();

          if (subscriptionDate.isAfter(today)) {
            emit(
              state.copyWith(
                errorMessage: "Login failed...",
                status: FormzStatus.submissionFailure,
              ),
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  title: const Text(
                    'Subscription',
                    style: TextStyle(
                        fontSize: 14,
                        color: blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  content: Text(
                    'Your subscription will start from $subscriptionDateStr.',
                    style: const TextStyle(
                        fontSize: 13,
                        color: blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                 actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        backgroundColor: successColor,
                        foregroundColor: whiteColor,
                      ),
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }
      } else if (result.containsKey('token')) {
        _storage.write(key: 'token', value: result['token']);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else if (result['status'] == 'error' && result.containsKey('invalid')) {
        emit(state.copyWith(
          errorMessage: result['invalid'],
          status: FormzStatus.submissionFailure,
        ));
      } else {
        emit(
          state.copyWith(
              errorMessage: "Login failed...",
              status: FormzStatus.submissionFailure),
        );
      }
    } catch (e, _) {
      emit(
        state.copyWith(
            errorMessage: "Login failed...",
            status: FormzStatus.submissionFailure),
      );
      print(e);
      print(_);
    }
  }
}
