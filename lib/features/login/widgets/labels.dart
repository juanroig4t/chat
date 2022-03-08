import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key,
    required this.ruta,
    required this.pregunta,
    required this.accion
  }) : super(key: key);

  final String ruta;
  final String pregunta;
  final String accion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text( pregunta ,
            style: TextStyle(color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Text(accion , style: TextStyle(color: Colors.blue.shade600,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
      ),
    );
  }
}