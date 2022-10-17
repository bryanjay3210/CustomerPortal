import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/account/components/customer_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    productProvider.getProduct({
      'customerId': mainProvider.user.CustomerID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID
    }, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
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
                      'Products',
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
                child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              child: Container(
                color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                child: StreamBuilder<DataState>(
                    stream: productProvider.productListState,
                    builder: (context, snapshot) {
                      if (snapshot.data == DataState.success &&
                          productProvider.products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/account/no-data.png',
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('No record found'),
                            ],
                          ),
                        );
                      }
                      if (snapshot.data == DataState.success &&
                          productProvider.products.isNotEmpty) {
                        return ListView.builder(
                          itemCount: productProvider.products.length,
                          itemBuilder: (context, index) {
                            final product = productProvider.products[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerProduct(planId: product.PlanID),
                                  )),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: mainProvider.darkTheme
                                        ? cpDarkContainerColor
                                        : const Color(0xffF5F5F5),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        informationText(
                                            'Plan No.', product.PlanID),
                                        informationText(
                                            'Plan Name', product.PlanName),
                                        Row(
                                          children: [
                                            informationText(
                                                'Start Date',
                                                jsTimeToDateTime(
                                                    product.PlanStartDate)),
                                            const SizedBox(
                                              width: 80,
                                            ),
                                            informationText(
                                                'End Date',
                                                jsTimeToDateTime(
                                                    product.PlanEndDate)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }),
              ),
            ))
          ],
        ));
  }

  Widget informationText(String title, String value) {
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
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
