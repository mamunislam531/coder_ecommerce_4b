import 'dart:convert';
import 'dart:developer';

import 'package:coder_ecommerce/widgets/appbar.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map userData = {};

  getUserData() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var d = await storage.read(key: "user-info");
    log("======D : $d");
    userData = jsonDecode(d!);
    log("======userData : ${userData['name']}");
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 30),
          SizedBox(height: 10,),
          CustomText(text: userData['name']),
          CustomText(text: userData['phone']),
          CustomText(text: userData['email']),
          CustomText(text: userData['address']),

          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person, size: 25),
                          CustomText(text: "My Profile", color: Colors.black),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person, size: 25),
                          CustomText(text: "My Profile", color: Colors.black),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person, size: 25),
                          CustomText(text: "My Profile", color: Colors.black),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person, size: 25),
                          CustomText(text: "My Profile", color: Colors.black),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
