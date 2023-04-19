import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential userData =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'Weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: 'Email already registered'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errMessage: 'Registration failed'));
      print(e);
    }
  }
}
