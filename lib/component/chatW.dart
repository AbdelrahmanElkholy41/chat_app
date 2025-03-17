import 'package:chat_app/model/messageModel.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class chatWuser extends StatelessWidget {
  const chatWuser({
    super.key, required this.message,
  });
 final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: KprimaryColor,
            borderRadius:BorderRadius.only(
              topLeft:Radius.circular(35),
              topRight: Radius.circular(35),
              bottomRight: Radius.circular(35),
            )
        ),
        child: Text(message.message,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}



class chatWanotherUser extends StatelessWidget {
  const chatWanotherUser({
    super.key, required this.message,
  });
 final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xff006D84),
            borderRadius:BorderRadius.only(
              topLeft:Radius.circular(35),
              topRight: Radius.circular(35),
              bottomLeft: Radius.circular(35),
            )
        ),
        child: Text(message.message,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}