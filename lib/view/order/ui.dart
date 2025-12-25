import 'dart:developer';

import 'package:coder_ecommerce/controller/order_list.dart';
import 'package:coder_ecommerce/widgets/button.dart';
import 'package:coder_ecommerce/widgets/text-field.dart';
import 'package:coder_ecommerce/widgets/text.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController searchC = TextEditingController();
  List orderData = [];
  bool isLoading = true;

  fetchOrderData() async {
    isLoading = true;
    orderData = await OrderListController().getData(phone: searchC.text);
    log("=========${orderData}");
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    fetchOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: CustomText(text: "MY ORDERS", fSize: 25),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(nameC: searchC, validator: (v) {}, title: "Phone"),
                ),
                Expanded(
                  child: CustomButton(
                    title: "Search",
                    onTap: () {
                      fetchOrderData();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            isLoading == true
                ? Center(child: CircularProgressIndicator())
                : orderData.isEmpty
                ? CustomText(text: "No Order Found")
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderData.length,
                    itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "${orderData[index]['order_id']}", fW: FontWeight.bold),
                                CustomText(text: "COD"),
                              ],
                            ),
                            CustomText(text: "${orderData[index]['customer_name']}  -  ${orderData[index]['customer_phone']}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text:
                                        "${orderData[index]['address']['street']}, ${orderData[index]['address']['upazila']},${orderData[index]['address']['district']}",
                                    fSize: 12,
                                    maxLine: 2,
                                  ),
                                ),
                                CustomText(text: "${orderData[index]['total_amount']} BDT", fSize: 13),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
