import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userData =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'User not registered'));
      } else if (ex.code == 'wrong password') {
        emit(LoginFailure(errMessage: 'Wrong password'));
      }
    } on Exception catch (e) {
      print(e);
      emit(LoginFailure(errMessage: 'Something went wrong'));
    }
  }
}
