

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  final String text;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Center(
        child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white),),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          elevation: 2,
          shape: StadiumBorder(),
      ),
    );
  }
}
