import 'dart:async';
import 'dart:convert';

import 'package:chat/core/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:users/domain/LoginRepsonse.dart';
import 'package:users/domain/Usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //Getters staticos
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environments.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (resp.statusCode == 200) {
      final _loginRepsonse = LoginRepsonse.fromJson(json.decode(resp.body));
      this.usuario = _loginRepsonse.usuario!;

      await _guardarToken(_loginRepsonse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environments.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (resp.statusCode == 200) {
      final _loginRepsonse = LoginRepsonse.fromJson(json.decode(resp.body));
      this.usuario = _loginRepsonse.usuario!;

      await _guardarToken(_loginRepsonse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get(Uri.parse('${Environments.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    if (resp.statusCode == 200) {
      final _loginRepsonse = LoginRepsonse.fromJson(json.decode(resp.body));
      this.usuario = _loginRepsonse.usuario!;
      await _guardarToken(_loginRepsonse.token);
      return true;
    } else {
      logout();
      return false;
    }

    return true;
  }

  Future _guardarToken(String? token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
