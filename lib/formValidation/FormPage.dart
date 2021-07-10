import 'package:bloc_example/formValidation/bloc/myform_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<MyformBloc, MyformState>(
          listener: (context, state) {
            print("caleled listeren");
            if (state.status.isSubmissionSuccess) {
              print("success");
              Scaffold.of(context).hideCurrentSnackBar();
              showDialog(
                context: context,
                builder: (_) =>
                    SuccessDialog(), //now create this success dialog widget
              );
            } else if (state.status.isSubmissionInProgress) {
              print("Progrees acall");
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Submitting...')),
                );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              child: Column(
                children: [EmailInput(), PasswordInput(), SubmitButton()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyformBloc, MyformState>(
      buildWhen: (previous, current) {
        print(previous.email);
        print(current.email);
        return previous.email != current.email;
      },
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          initialValue: state.email.value,
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.brown,
            ),
            labelText: 'Email',
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
          onChanged: (value) {
            final bloc = BlocProvider.of<MyformBloc>(context);
            bloc.add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyformBloc, MyformState>(
      buildWhen: (previous, current) {
        print(previous.password);
        print(current.password);
        return previous.password != current.password;
      },
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          initialValue: state.password.value,
          decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.brown),
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
          onChanged: (val) {
            final bloc = BlocProvider.of<MyformBloc>(context);
            bloc.add(PasswordChanged(password: val));
          },
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyformBloc, MyformState>(
      buildWhen: (previous, curret) => previous.status != curret.status,
      builder: (context, state) {
        return MaterialButton(
            color: Colors.brown,
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              state.status.isValidated
                  ? BlocProvider.of<MyformBloc>(context).add(FormSubmit())
                  : null;
            });
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.info),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flexible(
                      child: Text(
                    "Form Submit Successfully",
                    softWrap: true,
                  )),
                )
              ],
            ),
            MaterialButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
