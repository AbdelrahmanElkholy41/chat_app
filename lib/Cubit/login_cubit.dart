import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());




    Future<void> Login({required String Email,required String password}) async {

     emit(LoginLoading());
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: Email,
            password: password);
        emit(LoginSuccess());
      } on FirebaseAuthException catch (ex) {
        if(ex.code=='user-not-found'){
          emit(LoginFailuer('User Not found'));
        }else if(ex.code=='wrong-password'){
          emit(LoginFailuer('Wrong Password'));
        }

      }catch(e){
        emit(LoginFailuer('Something went wrong'));
      }
    }


}
