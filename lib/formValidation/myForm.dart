import 'package:bloc_example/formValidation/FormPage.dart';
import 'package:bloc_example/formValidation/bloc/myform_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<MyformBloc>(
        create: (context) => MyformBloc(),
        child: FormPage(),
      ),
    );
  }
}
