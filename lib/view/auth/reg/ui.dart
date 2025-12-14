import 'dart:convert';
import 'dart:developer';

import 'package:coder_ecommerce/controller/auth/reg.dart';
import 'package:flutter/material.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text-field.dart';
import '../../../widgets/text.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _LoginState();
}

class _LoginState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController addressC = TextEditingController();
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
          CustomText(text: "Let's Start", fSize: 22, color: Color(0xff5F5F5F)),
          SizedBox(height: 5),
          CustomTextField(
            nameC: nameC,
            validator: (v) {
              if (v == null || v == "") {
                return "Please enter Name";
              }
              return null;
            },
            title: 'Name',
          ),

          CustomTextField(
            nameC: phoneC,
            validator: (v) {
              if (v == null || v == "") {
                return "Please enter Phone";
              }
              return null;
            },
            title: 'Phone',
          ),
          CustomTextField(
            nameC: emailC,
            validator: (v) {
              if (v == null || v == "") {
                return "Please enter Email";
              }
              return null;
            },
            title: 'Email',
          ),
          CustomTextField(
            nameC: addressC,
            validator: (v) {
              if (v == null || v == "") {
                return "Please enter Address";
              }
              return null;
            },
            title: 'Address',
          ),
          CustomTextField(
            nameC: passC,
            validator: (v) {
              if (v == null || v == "") {
                return "Please enter Password";
              }
              return null;
            },
            title: 'Password',
          ),

          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : CustomButton(
                  title: 'Sign Up',
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    var a = {
                      "name": nameC.text,
                      "phone": phoneC.text,
                      "email": emailC.text,
                      "address": addressC.text,
                      "password": passC.text,
                    };

                    isLoading = true;
                    setState(() {});
                    bool status = await RegController().createAccountFun(data: a);
                    isLoading = false;
                    setState(() {});
                    if (status == true) {
                      /// Navigate Screen
                    }
                  },
                ),
        ],
      ),
    );
  }
}
