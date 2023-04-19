import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, required this.buttonText});

  String? buttonText;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            buttonText!,
            style: const TextStyle(color: Color(0xff2B475E)),
          ),
        ),
      ),
    );
  }
}
