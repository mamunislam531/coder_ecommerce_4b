import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.nameC, required this.validator, required this.title});

  final TextEditingController nameC;
  final FormFieldValidator validator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameC,
      validator: validator,
      decoration: InputDecoration(
        hintText: "Enter your $title",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
