import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.maxLine, this.color, this.fSize, this.fW, this.tD});
  final String text;
  final int? maxLine;
  final Color? color;
  final double? fSize;
  final FontWeight? fW;
  final TextDecoration? tD;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine ?? 1,
      style: TextStyle(
        color: color ?? Colors.grey,
        fontSize: fSize ?? 15,
        fontFamily: "myfont",
        fontWeight: fW ?? FontWeight.normal,
        decoration: tD ?? TextDecoration.none,
      ),
    );
  }
}
