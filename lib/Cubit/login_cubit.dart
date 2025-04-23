import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

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
      } on Exception catch (e) {
       emit(LoginFailuer());
      }
    }


}
