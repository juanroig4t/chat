
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(
            children: [
              Image(image: AssetImage('assets/tag-logo.png'),),
              SizedBox(height: 10,),
              Text(titulo, style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}