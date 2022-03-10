import 'package:chat/core/helpers/mostrar_alerta.dart';
import 'package:chat/core/widgets/custom_input.dart';
import 'package:chat/datasource/socket_service.dart';
import 'package:chat/features/login/widgets/labels.dart';
import 'package:chat/features/login/widgets/logo.dart';
import 'package:chat/core/widgets/custon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datasource/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(titulo: 'Login Chat'),
                  _Form(),
                  Labels(ruta: 'register', pregunta: '¿No tienes cuenta?', accion: 'Crea una ahora!',),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_open,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.text,
            textController: passwordController,
            isPassword: true,
          ),

          CustomButton(
            text: 'Acceder',
            onPressed: authService.autenticando ? () => {} : () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailController.text.trim(), passwordController.text.trim());

              if(loginOk) {
                socketService.connect();
                Navigator.of(context).pushReplacementNamed("usuarios");
              } else {
                mostrarAlerta(
                    context,
                    'Login incorrecto',
                    'Revisa el usuario y la contraseña'
                );
              }
            },
          )
        ],
      ),
    );
  }
}
