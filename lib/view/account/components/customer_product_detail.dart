import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/product_provider.dart';

class CustomerProductDetail extends StatefulWidget {
  final String productId;
  final String productName;
  const CustomerProductDetail(
      {Key? key, required this.productId, required this.productName})
      : super(key: key);

  @override
  State<CustomerProductDetail> createState() => _CustomerProductDetailState();
}

class _CustomerProductDetailState extends State<CustomerProductDetail> {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    var prodDetail = productProvider.customerProduct
        .where((element) => element.ProductID == widget.productId)
        .toList();
    var prodDetailInfo = prodDetail[0];
    return Scaffold(
      backgroundColor: const Color(0xff30313A),
      body: Column(
        children: [
          Container(
            color: const Color(0xff30313A),
            width: double.infinity,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: cpWhiteColor)),
                  const SizedBox(height: 30),
                  const Text(
                    'Product Detail',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: cpWhiteColor),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product Plan Information',
                    style: TextStyle(
                        color: mainProvider.darkTheme
                            ? cpWhiteColor
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                informationText('Plan Name', widget.productName, mainProvider),
                const Divider(
                  indent: 10,
                  thickness: 2,
                  endIndent: 10,
                ),
                Text('Customer Product Information',
                    style: TextStyle(
                        color: mainProvider.darkTheme
                            ? cpWhiteColor
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                informationText(
                    'Product Name', prodDetailInfo.ProductName, mainProvider),
                Row(
                  children: [
                    Expanded(
                        child: informationText(
                            'Start Date',
                            jsTimeToDateTime(prodDetailInfo.ProductStartDate),
                            mainProvider)),
                    Expanded(
                        child: informationText(
                            'End Date',
                            jsTimeToDateTime(prodDetailInfo.ProductEndDate),
                            mainProvider)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: informationText(
                            'Activation Fee',
                            '\$${double.parse(prodDetailInfo.ProductActivationCharge).toStringAsFixed(2)}',
                            mainProvider)),
                    Expanded(
                        child: informationText(
                            'Cycle Price',
                            '\$${double.parse(prodDetailInfo.ProductCyclePrice).toStringAsFixed(2)}',
                            mainProvider)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: informationText('Billing Cycle',
                            prodDetailInfo.ProductBillCycle, mainProvider)),
                    Expanded(
                        child: informationText(
                            'Active Product',
                            prodDetailInfo.IsProductActive.toString() == '1'
                                ? 'Yes'
                                : 'No',
                            mainProvider)),
                  ],
                ),
                informationText(
                    'Proratable',
                    prodDetailInfo.ProductProratable.toString() == 'Y'
                        ? 'Yes'
                        : 'No',
                    mainProvider),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget informationText(
      String title, String value, MainProvider mainProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 18,
              color: mainProvider.darkTheme ? cpWhiteColor : Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
