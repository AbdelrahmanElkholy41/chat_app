import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  register({required Email,required password}) async {

    emit(RegisterLoading());
      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword
          (email: Email, password: password);
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
         emit(RegisterFailure('Weak Password Please Add Strong Password'));
        } else if (e.code == 'email-already-in-use') {
         emit(RegisterFailure('email already exit'));
        }
      } catch(e){
        emit(RegisterFailure('there was an error'));
      }
      }

  }

