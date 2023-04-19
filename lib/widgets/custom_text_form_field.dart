import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key, this.hintText, this.onChanged, this.hidePasssword = false});

  Function(String)? onChanged;
  final String? hintText;
  final bool hidePasssword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidePasssword,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
