import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/formValidation/email.dart';
import 'package:bloc_example/formValidation/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'myform_event.dart';
part 'myform_state.dart';

class MyformBloc extends Bloc<MyformEvent, MyformState> {
  MyformBloc() : super(MyformState());
  @override
  void onTransition(Transition<MyformEvent, MyformState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

  @override
  Stream<MyformState> mapEventToState(
    MyformEvent event,
  ) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
          email: email, status: Formz.validate([email, state.email]));
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
          password: password,
          status: Formz.validate([password, state.password]));
    } else if (event is FormSubmit) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future.delayed(Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
