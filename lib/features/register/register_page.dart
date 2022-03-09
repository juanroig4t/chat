import 'package:chat/core/helpers/mostrar_alerta.dart';
import 'package:chat/core/widgets/custom_input.dart';
import 'package:chat/datasource/auth_service.dart';
import 'package:chat/features/login/widgets/labels.dart';
import 'package:chat/features/login/widgets/logo.dart';
import 'package:chat/core/widgets/custon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                children: const [
                  Logo(titulo: 'Register Chat'),
                  _Form(),
                  Labels(
                      ruta: 'login',
                      pregunta: '¿Ya tienes cuenta?',
                      accion: 'Acceder'),
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
  final nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person_outline,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nombreController,
          ),
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
            text: 'Registrar',
            onPressed: authService.autenticando
                ? null
                : () async {
                    print(emailController.text);
                    final registroOk = await authService.register(
                        nombreController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim()
                    );

                    if (registroOk == true) {

                    } else {
                      mostrarAlerta(context, 'Registro incorrecto', registroOk);
                    }

                  },
          )
        ],
      ),
    );
  }
}
