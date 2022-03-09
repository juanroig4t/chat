
import 'package:chat/datasource/auth_service.dart';
import 'package:chat/features/login/login_page.dart';
import 'package:chat/features/users/usuarios_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        }),
      );
  }

  Future checkLoginState( BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();
    
    if(autenticado) {
      // Navigator.of(context).pushReplacementNamed('usuarios');
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: ( _ , __ , ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 0)
          )
      );
    } else {
      //Navigator.of(context).pushReplacementNamed('login');
      Navigator.pushReplacement(context,
          PageRouteBuilder(
              pageBuilder: ( _ , __ , ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)
          )
      );
    }

  }
}