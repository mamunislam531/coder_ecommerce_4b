import 'package:coder_ecommerce/view/auth/ui.dart';
import 'package:coder_ecommerce/view/checkout/ui.dart';
import 'package:coder_ecommerce/view/home/ui.dart';
import 'package:coder_ecommerce/view/profile/ui.dart';
import 'package:coder_ecommerce/view/shipping_info/ui.dart';
import 'package:coder_ecommerce/view/splash/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
