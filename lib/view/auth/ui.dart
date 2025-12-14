import 'package:coder_ecommerce/view/auth/reg/ui.dart';
import 'package:coder_ecommerce/view/auth/widget/tabbar.dart';
import 'package:coder_ecommerce/widgets/appbar.dart';
import 'package:flutter/material.dart';

import 'login/ui.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabBarWidget(
                  title: "Sign In",
                  onTap: () {
                    selected = 1;
                    setState(() {});
                  },
                  selected: selected,
                ),

                TabBarWidget(
                  title: "Sign Up",
                  onTap: () {
                    selected = 2;
                    setState(() {});
                  },
                  selected: selected,
                ),
              ],
            ),
            SizedBox(height: 20,),
            selected == 1 ? Login() : RegScreen()   ,
          ],
        ),
      ),
    );
  }
}
