import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coder_ecommerce/controller/slider.dart';
import 'package:coder_ecommerce/widgets/appbar.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:coder_ecommerce/view/product/widget/product.dart';

import '../../controller/category.dart';
import '../../controller/selling_type.dart';
import '../product/ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List p = [
    {
      "id": 1,
      "title": "Men's Classic Cotton Head Cap",
      "stock": "75",
      "sku": "CAP-COT-BLK",
      "brand": "UrbanStyle",
      "price": "650",
      "old_price": "850",
      "image": "products/PgrKShWTkVMoWefUTr0YxLWiyRRrAXbl3joQrLXe.webp",
      "rating": "4.4",
      "review_count": "89",
      "category": "Head CAP",
    },
  ];
  List sliderList = [];
  List categoryList = [];
  Map sellingData = {};
  bool isLoading = true;

  fetchSliderData() async {
    sliderList = await SliderController().getSliderData();
    log("=======${sliderList}==");
  }

  fetchCategoryData() async {
    categoryList = await CategoryController().getCategoryData();
    log("=======${categoryList}==");
  }

  fetchSellingData() async {
    sellingData = await SellingTypeController().getSellingTypeData();
    log("=======${sellingData['hot-selling']}==");
    setState(() {});
  }

  getData() async {
    await fetchSliderData();
    await fetchCategoryData();
    await fetchSellingData();
    isLoading = false;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: ListView(
        children: [
          sliderList.isEmpty
              ? SizedBox()
              : CarouselSlider(
                  options: CarouselOptions(height: 147.0, viewportFraction: 1, autoPlay: true),
                  items: sliderList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage("https://eplay.coderangon.com/storage/${i['image']}"),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Categories", color: Colors.black),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 110,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          itemCount: categoryList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, i) => InkWell(
                            onTap: (){
                              log("=======${categoryList[i]['id']}====");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductScreen(title: "${categoryList[i]['id']}",)));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(2),
                                  height: 109,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage("https://eplay.coderangon.com/storage/${categoryList[i]['image']}"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 18,
                                    width: 90,
                                    color: Color(0xff201E1FCF),
                                    child: CustomText(text: "${categoryList[i]['name']}", color: Colors.white, fW: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Hot Selling
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Hot Selling", color: Colors.black),
                          InkWell(
                            onTap: () {
                              log("==============");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductScreen(title: "hot-selling",)));
                            },
                            child: CustomText(text: "See All", color: Colors.orange),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 268,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          itemCount: sellingData['hot-selling'].length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, i) => ProductCardWidget(data: sellingData['hot-selling'][i]),
                        ),
                      ),

                      // Top Selling
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Top Selling", color: Colors.black),
                          InkWell(
                            onTap: () {},
                            child: CustomText(text: "See All", color: Colors.orange),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 268,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          itemCount: sellingData['top-selling'].length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, i) => ProductCardWidget(data: sellingData['hot-selling'][i]),
                        ),
                      ),

                      // New Product
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "New Product", color: Colors.black),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductScreen(title: "latest",)));
                            },
                            child: CustomText(text: "See All", color: Colors.orange),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 268,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          itemCount: sellingData['hot-selling'].length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, i) => ProductCardWidget(data: sellingData['new-product'][i]),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
