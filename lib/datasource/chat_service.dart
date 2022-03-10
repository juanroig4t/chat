
import 'dart:convert';
import 'dart:io';

import 'package:chat/core/environment.dart';
import 'package:chat/datasource/auth_service.dart';
import 'package:chat/features/chat/models/MensajesResponse.dart';
import 'package:flutter/material.dart';
import 'package:users/domain/Usuario.dart';

import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier{

  late Usuario usuarioPara;

  Future getChat(String usuarioId) async{
    final resp = await http.get(Uri.parse('${Environments.apiUrl}/mensajes/$usuarioId'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': '${await AuthService.getToken()}'
      }
    );

    final mensajesResp = MensajesResponse.fromJson(json.decode(resp.body));

    return mensajesResp.mensajes;
  }

}