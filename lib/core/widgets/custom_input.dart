import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false
  }) : super(key: key);

  final IconData? icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( left: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0,5),
                blurRadius: 5
            )
          ]
      ),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon): null,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder
        ),
      ),
    );
  }
}
