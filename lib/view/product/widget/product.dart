import 'dart:developer';

import 'package:coder_ecommerce/view/product_details/ui.dart';
import 'package:flutter/material.dart';
import '../../../widgets/text.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        log("======ID :${data['id']}========");
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ProductDetails(pID: data['id'],)));
      },
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                spacing: 8,
                children: [
                  Container(
                    height: 156,
                    width: 173,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://eplay.coderangon.com/public/storage/${data['image']}",
                        ),
                      ),
                    ),
                  ),
                  CustomText(text: data['title'], fW: FontWeight.w500, fSize: 12, color: Colors.black, maxLine: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      CustomText(text: data['price'], fW: FontWeight.w500, fSize: 14, color: Colors.black),
                      CustomText(text: data['old_price'], fW: FontWeight.w500, fSize: 14, tD: TextDecoration.lineThrough),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: CustomText(text: "Add to Cart", fSize: 13, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(left: 25, child: Image.asset("asset/images/offer.png")),
        ],
      ),
    );
  }
}
