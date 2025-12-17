import 'dart:developer';

import 'package:coder_ecommerce/controller/auth/login.dart';
import 'package:coder_ecommerce/view/product/ui.dart';
import 'package:coder_ecommerce/widgets/button.dart';
import 'package:flutter/material.dart';
import '../../../widgets/loading_button.dart';
import '../../../widgets/text-field.dart';
import '../../../widgets/text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "Welcome Back", fSize: 22, color: Color(0xff5F5F5F)),
          CustomText(text: "Please enter your details to login."),
          SizedBox(height: 5),

          CustomTextField(
            nameC: phoneC,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Please Enter Phone";
              } else {
                return null;
              }
            },
            title: 'Phone',
          ),

          CustomTextField(
            nameC: passC,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Please Enter password";
              } else {
                return null;
              }
            },
            title: "Password",
          ),
          isLoading == true
              ? CustomLoadingButton()
              : CustomButton(
                  title: "Login",
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    isLoading = true;
                    setState(() {});
                    var status = await LoginController.login(phone: phoneC.text, pass: passC.text);
                    log("========${status}===");
                    isLoading = false;
                    setState(() {});
                    if (status) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => ProductScreen()));
                    }
                  },
                ),
        ],
      ),
    );
  }
}
