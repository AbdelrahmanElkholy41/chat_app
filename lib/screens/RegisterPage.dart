import 'package:chat_app/Cubit/register_cubit.dart';
import 'package:chat_app/screens/ChatPage.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/CustomButton.dart';
import '../component/customTextField.dart';
import '../constants.dart';

class Registerpage extends StatelessWidget {
   Registerpage({super.key});
  static String id = 'register';
  
  String? Email;

  String? password;

bool isLoading=false;

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
   if(state is RegisterLoading){
     isLoading =true;
   }
   else if(state is RegisterSuccess){
     isLoading=false;
     Navigator.pushNamed(context, Chatpage.id);

   }
   else if(state is RegisterFailure){
     showSnackBar(context,state.errMessage);
     isLoading=false;

   }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              color: KprimaryColor,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Form(
                    key:formKey ,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(
                            flex: 2,
                          ),
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
                          Spacer(
                            flex: 2,
                          ),
                          Text(
                            'Register',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Customtextfield(
                            hintText: 'Email',
                            onChange: (data){
                              Email=data;
                            },

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Customtextfield(
                            hintText: 'password',
                            onChange: (data){
                              password=data;
                            }, obsec: true,

                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Custombutton(
                            action: 'Register',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context).register(Email: Email, password: password);
                              }
                            }
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' already have an account ',
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Color(0XFFC7EDE6)),
                                  ))
                            ],
                          ),
                          Spacer(
                            flex: 3,
                          )
                        ]),
                  )))),
    );
  },
);
  }

  void showSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

 
}
