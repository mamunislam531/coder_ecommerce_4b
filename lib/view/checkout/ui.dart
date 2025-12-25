import 'dart:convert';
import 'dart:developer';
import 'package:coder_ecommerce/controller/checkout.dart';
import 'package:coder_ecommerce/view/home/ui.dart';
import 'package:coder_ecommerce/view/shipping_info/ui.dart';
import 'package:coder_ecommerce/widgets/button.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.productData});
  final Map productData;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map userData = {};
  Map product = {};

  getUserData() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var d = await storage.read(key: "shipping");
    log("======D : $d");
    if (d != null) {
      userData = jsonDecode(d);
      log("======userData : ${userData['name']}");
    }
    setState(() {});
  }

  getProductData() async {
    product = widget.productData;
    log("==PPP : ${product}");
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Checkout", fSize: 25, color: Colors.black),
        actions: [
          InkWell(
            onTap: () {
              FlutterSecureStorage storage = FlutterSecureStorage();
              storage.delete(key: "shipping");
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "Shipping Information", fSize: 20),
            userData.isEmpty
                ? InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingScreen())).then((b) {
                        getUserData();
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              spacing: 10,
                              children: [
                                Icon(Icons.add_box_rounded),
                                CustomText(text: "Add Shipping Information"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(text: "Name : "),
                                  Expanded(child: CustomText(text: "${userData['name']}")),
                                ],
                              ),
                              Row(
                                children: [
                                  CustomText(text: "Phone : "),
                                  Expanded(child: CustomText(text: "${userData['phone']}")),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: "Address : "),
                                  Expanded(
                                    child: CustomText(
                                      text: "${userData['street']}, ${userData['upazila']}, ${userData['district']}",
                                      maxLine: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingScreen())).then((v) {
                              getUserData();
                            });
                          },
                          child: Icon(Icons.edit_note),
                        ),
                      ),
                    ],
                  ),

            SizedBox(height: 20),
            CustomText(text: "Products", fSize: 20),
            Card(
              child: Row(
                spacing: 20,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("https://eplay.coderangon.com/storage/${product['image']}"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "${product['title']}"),
                        CustomText(text: "brand : ${product['brand']}"),
                        Row(
                          spacing: 10,
                          children: [
                            CustomText(text: "BDT ${product['price']}", fSize: 16),
                            CustomText(text: " ${product['old_price']}", tD: TextDecoration.lineThrough),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              title: "Checkout",
              onTap: () async {
                var checkout = {
                  "customer_name": userData['name'],
                  "customer_phone": userData['phone'],
                  "payment_method": "cod",
                  "items": [
                    {"product_id": product['id'], "product_name": product['title'], "price": product['price'], "quantity": 1},
                  ],
                  "address": {"street": userData['street'], "upazila": userData['upazila'], "district": userData['district']},
                };
                log("========Check : ${jsonEncode(checkout)}=====");
                bool status = await CheckOutService().sentData(data: checkout);
                if (status == true) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
