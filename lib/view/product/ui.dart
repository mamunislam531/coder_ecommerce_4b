import 'dart:developer';

import 'package:coder_ecommerce/view/product/widget/product.dart';
import 'package:coder_ecommerce/widgets/appbar.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';

import '../../controller/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List productList = [];
  bool isLoading = true;

  fetchData() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    productList = await GetProductController().getProduct();
    log("=====${productList.length}===");
    isLoading = false;
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
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              itemCount: productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                childAspectRatio: .55,
              ),
              itemBuilder: (context, index) => ProductCardWidget(data: productList[index]),
            ),
    );
  }
}
