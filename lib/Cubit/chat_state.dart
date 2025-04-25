part of 'chat_cubit.dart';


sealed class ChatState {}

final class ChatSuccess extends ChatState {
  List<Message>message;

  ChatSuccess(this.message);

}
class ChatIni extends ChatState{

}
