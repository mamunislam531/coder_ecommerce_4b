import 'dart:developer';

import 'package:coder_ecommerce/view/auth/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../product/ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  autoNavigate() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var t = await storage.read(key: "token");
    log("==T : $t==");
    if (t == null) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => AuthScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (c) => ProductScreen()));
    }
  }

  @override
  void initState() {
    autoNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("asset/images/logo.jpg")));
  }
}
