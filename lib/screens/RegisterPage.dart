import 'package:chat_app/screens/ChatPage.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/CustomButton.dart';
import '../component/customTextField.dart';
import '../constants.dart';

class Registerpage extends StatefulWidget {
   Registerpage({super.key});
  static String id = 'register';

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String? Email;

  String? password;

bool isLoading=false;

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                                isLoading=true;
                                setState(() {

                                });
                                try {
                                  await registerUser();

                                  Navigator.pushNamed(context,Chatpage.id);
                                }
                                on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showSnackBar(context, 'weak-password');
                                  } else if (e.code == 'email-already-in-use') {
                                    showSnackBar(context, 'email already exit');
                                  }
                                } catch (e) {
                                  showSnackBar(context, 'there was an error');
                                }
                                isLoading=false;
                                setState(() {

                                });

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
  }

  void showSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void>registerUser()async{
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword
      (email: Email!, password: password!);
  }
}
