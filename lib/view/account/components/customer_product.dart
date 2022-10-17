import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/account/components/customer_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/product_provider.dart';

class CustomerProduct extends StatefulWidget {
  final String planId;
  const CustomerProduct({Key? key, required this.planId}) : super(key: key);

  @override
  State<CustomerProduct> createState() => _CustomerProductState();
}

class _CustomerProductState extends State<CustomerProduct> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getCustomerProduct({
        'customerId': mainProvider.user.CustomerID,
        'planID': widget.planId,
        'userId': mainProvider.user.UserID,
        'server': mainProvider.server,
      }, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    var productInfo = productProvider.products
        .where((element) => element.PlanID == widget.planId)
        .toList();
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
                    'Customer Products',
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
                  informationText(
                      'Plan Name', productInfo[0].PlanName, mainProvider),
                  informationText(
                      'Start Date',
                      jsTimeToDateTime(productInfo[0].PlanStartDate),
                      mainProvider),
                  informationText(
                      'Term Date',
                      jsTimeToDateTime(productInfo[0].PlanEndDate),
                      mainProvider),
                  const Divider(
                    indent: 10,
                    thickness: 2,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Customer Products',
                      style: TextStyle(
                          color: mainProvider.darkTheme
                              ? cpWhiteColor
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: StreamBuilder(
                      stream: productProvider.productListState,
                      builder: (context, snapshot) {
                        if (productProvider.customerProduct.isEmpty &&
                            snapshot.data == DataState.success) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/account/no-data.png',
                                  height: 80,
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('No record found'),
                              ],
                            ),
                          );
                        }
                        if (productProvider.customerProduct.isNotEmpty &&
                            snapshot.data == DataState.success) {
                          return ListView.builder(
                            itemCount: productProvider.customerProduct.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => CustomerProductDetail(
                                    productId: productProvider
                                        .customerProduct[index].ProductID
                                        .toString(),
                                    productName: productInfo[0].PlanName,
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: mainProvider.darkTheme
                                            ? cpDarkContainerColor
                                            : const Color(0xffF5F5F5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          informationText(
                                              'Product No.',
                                              productProvider
                                                  .customerProduct[index]
                                                  .ProductID
                                                  .toString(),
                                              mainProvider),
                                          informationText(
                                              'Product Name.',
                                              productProvider
                                                  .customerProduct[index]
                                                  .ProductName
                                                  .toString(),
                                              mainProvider),
                                          informationText(
                                              'Start Date.',
                                              jsTimeToDateTime(productProvider
                                                  .customerProduct[index]
                                                  .ProductStartDate
                                                  .toString()),
                                              mainProvider),
                                          informationText(
                                              'End Date.',
                                              jsTimeToDateTime(productProvider
                                                  .customerProduct[index]
                                                  .ProductEndDate
                                                  .toString()),
                                              mainProvider),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
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
