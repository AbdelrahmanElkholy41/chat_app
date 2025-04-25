import 'package:chat_app/Cubit/chat_cubit.dart';
import 'package:chat_app/Cubit/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/CustomButton.dart';
import '../component/customTextField.dart';
import '../constants.dart';
import 'ChatPage.dart';
import 'RegisterPage.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  static String id='login';

  String? Email;

  String? password;

  bool isLoading = false;

  GlobalKey <FormState>formkeey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state)
    {
      if (state is LoginLoading) {
        isLoading = true;
      }
      else if (state is LoginSuccess) {
       BlocProvider.of<ChatCubit>(context).getMessage();
        Navigator.pushNamed(context, Chatpage.id);
        isLoading=false;



      } else if (state is LoginFailuer) {
        ScaffoldMessage(context, state.errMessage);
        isLoading=false;
      }
    },
      builder:(context,state)=> ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(

            body: Container(
                color: KprimaryColor,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Form(
                      key: formkeey,
                      child: ListView(

                          children: [
                            SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/scholar.png'),
                              ],
                            ),
                            Center(
                                child: Text(
                                  'Scholar Chat',
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontFamily: 'pacific'),
                                )),
                            SizedBox(height: 50,),
                            Text(
                              'Sign In',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Customtextfield(

                              hintText: 'Email',
                              onChange: (data) {
                                Email = data;
                              },

                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Customtextfield(
                              obsec: true,
                              hintText: 'password',
                              onChange: (data) {
                                password = data;
                              },

                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Custombutton(
                              action: 'LOGIN',
                              onTap: () async {
                                if (formkeey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).Login(Email: Email!, password: password!);


                                }else{
                                  ScaffoldMessage(context,'Failed to login please try again');
                                }
                              }
                              ,),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'do not have an account ',
                                  style: TextStyle(color: Colors.white),
                                ),

                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          Registerpage.id);
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: Color(0XFFC7EDE6)),
                                    ))
                              ],
                            ),
                            SizedBox(height: 150,)
                          ]),
                    )))),
      ),
    );
  }

  void ScaffoldMessage(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }


}