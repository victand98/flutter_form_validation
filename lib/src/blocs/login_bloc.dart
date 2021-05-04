import 'dart:async';

import 'package:flutter_form_validation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Retrieving stream data
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream => Rx.combineLatest2(
        emailStream,
        passwordStream,
        (a, b) => true,
      );

  // Inserting values into the Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Closing the streams
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
