import 'dart:developer';
import 'package:coder_ecommerce/view/product/widget/product.dart';
import 'package:coder_ecommerce/widgets/appbar.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';
import '../../controller/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.title});

  final String title;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List productFinalList = [];
  List productList = [];
  bool isLoading = true;

  fetchData() async {
    isLoading = true;
    setState(() {});
    productFinalList = await GetProductController().getProduct(t: widget.title);
    productList = productFinalList;
    isLoading = false;
    setState(() {});
  }

  searchData({required String search}) {
    log(":-------search ${search}--------");
    productList = productFinalList.where((v) => v['title'].toString().toLowerCase().contains(search.toLowerCase())).toList();
    log("=====PL : ${productList.length}");
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (v) {
                log("========${v}==========");
                searchData(search: v.toString());
              },
              decoration: InputDecoration(
                hintText: "Search here...",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),

          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : productList.isEmpty
              ? Center(child: CustomText(text: "Product Not Found"))
              : Expanded(
                  child: GridView.builder(
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
                ),
        ],
      ),
    );
  }
}
