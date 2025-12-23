import 'dart:developer';

import 'package:coder_ecommerce/view/auth/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,

      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(child: Image.asset("asset/images/back.png")),
            ),
            Image.asset(height: 30, "asset/images/app-logo.png"),
            InkWell(
              onTap: () async {
                log("==============");
                FlutterSecureStorage storage = FlutterSecureStorage();
               var d = await storage.read(key: "user-info");
               log("=======d : $d");
               },
              child: Icon(Icons.refresh),
            ),  InkWell(
              onTap: () {
                log("==============");
                FlutterSecureStorage storage = FlutterSecureStorage();
                storage.deleteAll();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
              },
              child: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
