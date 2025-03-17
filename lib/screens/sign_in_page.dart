import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/CustomButton.dart';
import '../component/customTextField.dart';
import '../constants.dart';
import 'ChatPage.dart';
import 'RegisterPage.dart';

class SignInPage extends StatefulWidget {
   SignInPage({super.key});
static String id='login';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? Email;

  String? password;

  bool isLoading=false;

GlobalKey <FormState>formkeey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                            onChange: (data){
                              Email=data;
                            },

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Customtextfield(
                            obsec: true,
                            hintText: 'password',
                            onChange: (data){
                              password=data;
                            },

                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Custombutton(
                            action: 'LOGIN',
                            onTap: ()async {
                              if (formkeey.currentState!.validate()) {
                                isLoading=true;
                                setState((){});

                                try {
                                  await Login();
                                  Navigator.pushNamed(context,Chatpage.id,arguments: Email);
                                }
                                on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {

                                    ScaffoldMessage(context, 'User not found');
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessage(context, 'Wrong Password');
                                  }
                                }catch(e){
                                  ScaffoldMessage(context, e);
                                }
                                isLoading=false;
                                setState((){});
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
                                    Navigator.pushNamed(context,Registerpage.id);
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
    );
  }

  void ScaffoldMessage(BuildContext context,message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> Login() async {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email!,
        password: password!);
  }
}
