import 'dart:convert';
import 'dart:developer';

import 'package:coder_ecommerce/controller/auth/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text-field.dart';
import '../../../widgets/text.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _LoginState();
}

class _LoginState extends State<ShippingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController streetC = TextEditingController();
  final TextEditingController upazilaC = TextEditingController();
  final TextEditingController districtC = TextEditingController();
  bool isLoading = false;

  Map userData = {};

  getUserData() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var d = await storage.read(key: "shipping");
    log("======D : $d");
    if (d != null) {
      userData = jsonDecode(d);
      log("======userData : ${userData['name']}");
      nameC.text = userData['name'];
      phoneC.text = userData['phone'];
      streetC.text = userData['street'];
      upazilaC.text = userData['upazila'];
      districtC.text = userData['district'];
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Shipping Information", fSize: 25, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                  nameC: streetC,
                  validator: (v) {
                    if (v == null || v == "") {
                      return "Please enter Street";
                    }
                    return null;
                  },
                  title: 'Street',
                ),
                CustomTextField(
                  nameC: upazilaC,
                  validator: (v) {
                    if (v == null || v == "") {
                      return "Please enter Upazela";
                    }
                    return null;
                  },
                  title: 'Upazela',
                ),
                CustomTextField(
                  nameC: districtC,
                  validator: (v) {
                    if (v == null || v == "") {
                      return "Please enter District";
                    }
                    return null;
                  },
                  title: 'District',
                ),

                isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        title: 'Next',
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          var data = {
                            "name": nameC.text,
                            "phone": phoneC.text,
                            "street": streetC.text,
                            "upazila": upazilaC.text,
                            "district": districtC.text,
                          };
                          log("===========${data}==");
                          FlutterSecureStorage storage = FlutterSecureStorage();
                          await storage.write(key: "shipping", value: jsonEncode(data));
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
