import 'package:chat_app/config/helpers/get_yes_no_answer.dart';
import 'package:chat_app/domain/entities/message.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();
  List<Message> messageList = [
    Message(text: 'holas', fromWho: FromWho.me),
    Message(text: 'ya regresaste del trabajo?', fromWho: FromWho.me),
  ];
  Future<void> sendMessage(String text) async {
    //si manda un mensaj vacion, que no haga nada
    if (text.isEmpty) return;
    // TODO: implementar metodo
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    //esto evaluara si se esta preguntando por la caja de texto
    if (text.endsWith('?')) {
      herReply();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    //esto traera el texto despues de la pregunta
    messageList.add(herMessage);
    notifyListeners();

    moveScrollToBottom();
  }

//esto hace la animacion que se muestre los mensajes ya despues de enviarlos
  Future<void> moveScrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
