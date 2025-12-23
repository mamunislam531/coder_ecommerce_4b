import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_ecommerce/controller/p_details.dart';
import 'package:coder_ecommerce/widgets/appbar.dart';
import 'package:coder_ecommerce/widgets/button.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';

import '../checkout/ui.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.pID});

  final int pID;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Map data = {};
  List<String> imgList = [];

  fetchData() async {
    data = await GetProductDetails().getData(id: widget.pID);
    if (data.isNotEmpty) {
      for (var i in data['gallery']) {
        imgList.add(i);
      }
    }
    log("=======Da : $data");
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 210.0, viewportFraction: .9, autoPlay: true),
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://eplay.coderangon.com/public/storage/$i"),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "${data['title']}", color: Colors.black, fSize: 20),
                  CustomText(text: "SKU : ${data['sku']}", color: Colors.black),
                  CustomText(text: "brand : ${data['brand']}", color: Colors.black),
                  CustomText(text: "category : ${data['category']}", color: Colors.black),
                  CustomText(text: "stock : ${data['stock']} Pcs", color: Colors.black),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 10),
                      CustomText(text: "(${data['stock']} Reviews)", color: Colors.black, fSize: 20),
                    ],
                  ),

                  Row(
                    spacing: 10,
                    children: [
                      CustomText(text: "Price : ", color: Colors.black),
                      CustomText(text: "${data['price']}", color: Colors.black),
                      CustomText(text: "${data['old_price']}", tD: TextDecoration.lineThrough, maxLine: 20),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomText(text: "Details", color: Colors.black),
                  CustomText(text: "${data['description']}", color: Colors.black),

                  SizedBox(height: 200),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: CustomButton(
          title: "Buy Now",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen()));
          },
        ),
      ),
    );
  }
}
