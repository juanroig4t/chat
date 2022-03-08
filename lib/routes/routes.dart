import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loadin_page.dart';
import 'package:chat/features/login/login_page.dart';
import 'package:chat/features/register/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),

};