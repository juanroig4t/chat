import 'dart:convert';

import 'package:chat/core/environment.dart';
import 'package:chat/datasource/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:users/domain/Usuario.dart';
import 'package:users/domain/UsuariosResponse.dart';

class UsuarioService {

  Future<List<Usuario>> getUsuarios() async {
    try{
      final resp = await http.get(Uri.parse('${Environments.apiUrl}/usuarios'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': '${await AuthService.getToken()}'
      });
      
      final usuariosResponse = UsuariosResponse.fromJson(json.decode(resp.body));

      return usuariosResponse.usuarios ?? [];
    } catch(e){
      return [];
    }
  }
}