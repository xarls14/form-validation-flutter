import 'dart:async';

import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();  


  //recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  //combinar streams
  Stream<bool> get formValidStream => 
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al stream
  Function get changeEmail => _emailController.sink.add;
  Function get changePassword => _passwordController.sink.add;

  //obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}