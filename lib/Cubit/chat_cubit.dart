import 'package:bloc/bloc.dart';
import 'package:chat_app/model/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatIni());

  CollectionReference message = FirebaseFirestore.instance.collection('message');
sendMessage({required String data,required String email}){
  message.add({
    'message': data,
    'createdAt':DateTime.now(),
    'id': email
  });

}

getMessage(){
  message.orderBy('createdAt',descending: true).snapshots().listen((event){
   List<Message>messageList=[];
   for(var doc in event.docs){
     messageList.add(Message.fromJson(doc));
   }
    emit(ChatSuccess(messageList));
  });
}



}
