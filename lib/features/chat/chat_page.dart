
import 'dart:ffi';
import 'dart:io';

import 'package:chat/core/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  List<ChatMessage> _messages = [

  ];

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue.shade100,
              maxRadius: 15,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Juan Ra',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                  itemCount: _messages.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) => _messages[i],
                  reverse: true,
            )
            ),
            Divider(height: 5,),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {

    return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmit,
                    onChanged: (texto) {
                      setState(() {
                        if (texto.trim().length > 0){
                          _estaEscribiendo = true;
                        } else {
                          _estaEscribiendo = false;
                        }
                      });

                    },
                    decoration: InputDecoration.collapsed(
                        hintText: 'Enviar mensaje'
                    ),
                    focusNode: _focusNode,
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                    ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                )
                    : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(
                        color: Colors.blue.shade400
                    ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send,),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    ),
                  ),
                )

              )
            ],
          ),
        )
    );
  }

  _handleSubmit(String texto) {
    if (texto.trim().length == 0 ) return;
    
    _textController.clear();
    _focusNode.requestFocus();
    
    final newMessage = ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 200)
      ),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
}