part of 'myform_bloc.dart';

class MyformState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const MyformState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});
  MyformState copyWith({Email email, Password password, FormzStatus status}) {
    return MyformState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, status];
}
