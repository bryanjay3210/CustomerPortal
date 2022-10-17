import 'package:cp/model/unit_info/unit_info.dart';
import 'package:cp/shared_widgets/shared_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../provider/main_provider.dart';
import '../../../provider/manager/customer_provider.dart';
import '../../../utils/utils/theme/global_colors.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final searchCtrler = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      Provider.of<CustomerProvider>(context, listen: false).getCustomers({
        'buildingId': mainProvider.user.CustomerID,
        'server': mainProvider.server,
      }, context);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: StreamBuilder<DataState>(
          stream: customerProvider.customers$,
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data == DataState.loading) {
              return const SizedBox();
            }
            if (snapshot.data == DataState.empty) {
              return const SizedBox();
            }
            return FloatingActionButton(
              onPressed: () {
                customerProvider.selectedCustomer = UnitInfo();
                Navigator.pushNamed(context, 'customer_details');
              },
              backgroundColor: cpPrimaryColor,
              child: const Icon(Icons.add),
            );
          }),
      body: SizedBox(
        height: mqHeight(context),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  color: cpGreyDarkColor,
                ),
                const SizedBox(),
              ],
            ),
            Positioned(
              height: mqHeight(context) * .90,
              top: 20,
              left: 5,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Customers',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, right: 15, left: 15),
                    child: textFieldShared2(context,
                        ctrler: searchCtrler,
                        isFloatingLabel: false,
                        prefixIcon: const Icon(Icons.search),
                        labelText: 'Search Customer...',
                        fillColor: Colors.white, onChanged: (text) {
                      customerProvider.keywordSearch = text;
                      customerProvider.filterCustomers(text);
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<DataState>(
                              stream: customerProvider.customers$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null ||
                                    snapshot.data == DataState.loading) {
                                  return const SizedBox(
                                    height: 300,
                                    child: Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                  );
                                }
                                if (snapshot.data == DataState.empty) {
                                  return const SizedBox(
                                    height: 300,
                                    child: Center(
                                        child: Text('Customer does not exist')),
                                  );
                                }
                                final data = customerProvider.customers;
                                return Container(
                                    height: (data.length * 72.5) + 30,
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: mainProvider.darkTheme
                                          ? cpDarkContainerColor
                                          : cpGreyLightColor,
                                    ),
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            customerProvider.customers.length +
                                                1,
                                        itemBuilder: (context, ctx) {
                                          if (ctx ==
                                              customerProvider
                                                  .customers.length) {
                                            return const SizedBox(height: 50);
                                          }
                                          final customer =
                                              customerProvider.customers[ctx];
                                          return ListTile(
                                            onTap: () {
                                              customerProvider
                                                  .selectedCustomer = data[ctx];
                                              Navigator.pushNamed(
                                                  context, 'customer_details');
                                              customerProvider.suspend$.add(
                                                  customer.Suspended == 'Y'
                                                      ? true
                                                      : false);
                                            },
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '${customer.UserFname} ${customer.UserLname}'),
                                                ),
                                                Text(
                                                    'Acc. #: ${customer.CustomerID}')
                                              ],
                                            ),
                                            subtitle: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(customer.CustomerName
                                                          is Map
                                                      ? ''
                                                      : customer.CustomerName),
                                                  Row(
                                                    children: [
                                                      Text(customer.UnitName),
                                                      const SizedBox(width: 10),
                                                      Icon(
                                                        Icons.circle,
                                                        color:
                                                            customer.Suspended ==
                                                                    'Y'
                                                                ? Colors.red
                                                                : Colors.green,
                                                        size: 15,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ]),
                                          );
                                        }));
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
