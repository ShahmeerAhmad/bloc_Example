part of 'myform_bloc.dart';

abstract class MyformEvent extends Equatable {
  const MyformEvent();

  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class EmailChanged extends MyformEvent {
  final String email;
  const EmailChanged({@required this.email});
  @override
  List<Object> get props => [email];
}

class PasswordChanged extends MyformEvent {
  final String password;
  const PasswordChanged({@required this.password});
  @override
  List<Object> get props => [password];
}

class FormSubmit extends MyformEvent {}
