import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onTap, this.pad});

  final String title;
  final VoidCallback onTap;
  final double? pad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Color(0xffF4A758),
        child: Padding(
          padding: EdgeInsets.all(pad ?? 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomText(text: title, color: Colors.white, fW: FontWeight.w600)],
          ),
        ),
      ),
    );
  }
}
