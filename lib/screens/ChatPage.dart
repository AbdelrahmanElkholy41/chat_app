import 'package:chat_app/Cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/chatW.dart';
import '../constants.dart';
import '../model/messageModel.dart';


class Chatpage extends StatelessWidget {
  Chatpage({super.key});

  static String id = 'Chat page';


  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();


  List<Message>messageL = [];

  @override
  Widget build(BuildContext context) {
   var email=FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 50,),
            Text('Chat', style: TextStyle(color: Colors.white),)

          ],

        ),

      ),

      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if(state is ChatSuccess ){
                  messageL=state.message;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageL.length,
                  itemBuilder: (BuildContext context, int index) {
                    return messageL[index].id == email ? chatWuser(
                      message: messageL[index],)

                        : chatWanotherUser(message: messageL[index],);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {

                BlocProvider.of<ChatCubit>(context).sendMessage(data: data, email:email.toString());
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },

              decoration: InputDecoration(
                  hintText: 'send Message',
                  suffixIcon: Icon(Icons.send, color: KprimaryColor,),
                  border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(16)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: KprimaryColor,
                      )
                  )


              ),
            ),
          )
        ],

      ),

    );
  }
}


//
// if(snapshot.hasData) {
// List<Message>messageL=[];
// for(int i=-0 ;i<snapshot.data!.docs.length;i++){
// messageL.add(Message.fromJson(snapshot.data!.docs[i]));