import 'package:cp/shared_widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../provider/main_provider.dart';
import '../../../provider/manager/customer_provider.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../shared_widgets/shared_text_field.dart';
import '../../../utils/utils/theme/global_colors.dart';
import '../../shared_widgets/button.dart';
import '../../shared_widgets/common_widgets.dart';

class WifiUserListPage extends StatefulWidget {
  const WifiUserListPage({Key? key}) : super(key: key);

  @override
  State<WifiUserListPage> createState() => _WifiUserListPageState();
}

class _WifiUserListPageState extends State<WifiUserListPage> {
  final usernameCtrler = TextEditingController();
  final passcodeCtrler = TextEditingController();
  final confirmPasscodeCtrler = TextEditingController();
  final searchCtrler = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final customerProvider =
          Provider.of<CustomerProvider>(context, listen: false);
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      customerProvider.getWifiUsers({
        'userId': customerProvider.selectedCustomer.UserID,
        'server': mainProvider.server,
      }, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: cpPrimaryColor,
          onPressed: () {
            usernameCtrler.clear();
            passcodeCtrler.clear();
            confirmPasscodeCtrler.clear();
            showWifiContainer(false);
          },
          child: const Icon(Icons.add)),
      appBar: popUpPageAppBar('Manage Wifi Users'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 15, left: 15),
              child: textFieldShared2(context,
                  ctrler: searchCtrler,
                  isFloatingLabel: false,
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search Wifi User...',
                  fillColor: Colors.white, onChanged: (text) {
                customerProvider.filterWifiUsers(text);
              }),
            ),
            const SizedBox(height: 10),
            StreamBuilder<DataState>(
                stream: customerProvider.wifiUsers$,
                builder: (context, snapshot) {
                  if (snapshot.data == null ||
                      snapshot.data == DataState.loading) {
                    return const SizedBox(
                      height: 300,
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    );
                  }
                  if (snapshot.data == DataState.empty) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: Text('Nothing to show')),
                    );
                  }

                  final data = customerProvider.wifiUsers;
                  return Container(
                    height: data.length * 70,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Provider.of<MainProvider>(context).darkTheme
                          ? cpDarkContainerColor
                          : cpGreyLightColor,
                    ),
                    child: ListView.builder(
                        itemCount: customerProvider.wifiUsers.length + 1,
                        itemBuilder: (context, ctx) {
                          if (ctx == customerProvider.wifiUsers.length) {
                            return const SizedBox(height: 0);
                          }
                          final customer = customerProvider.wifiUsers[ctx];

                          return ListTile(
                              onTap: () {
                                customerProvider.selectedWifiUser = data[ctx];
                                usernameCtrler.text = data[ctx].WifiUserName;
                                passcodeCtrler.text = data[ctx].WifiPassword;
                                confirmPasscodeCtrler.text =
                                    data[ctx].WifiPassword;

                                showWifiContainer(true,
                                    wifiId: data[ctx].WifiUserID);
                              },
                              title: Text(customer.WifiUserName),
                              subtitle: Text(customer.WifiUserID));
                        }),
                  );
                }),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  showWifiContainer(bool isEdit, {String? wifiId}) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    showDialogShared(
        context,
        SingleChildScrollView(
          child: Container(
            height: isEdit ? 450 : 380,
            width: 330,
            decoration: BoxDecoration(
              color: mainProvider.darkTheme
                  ? cpDarkContainerColor
                  : cpGreyLightColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    isEdit ? 'Edit Wifi User' : 'New Wifi User',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: mainProvider.darkTheme
                          ? cpWhiteColor
                          : cpGreyDarkColor,
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameCtrler,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: cpGreyLightColor400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passcodeCtrler,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: cpGreyLightColor400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: confirmPasscodeCtrler,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              color: cpGreyLightColor400,
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: StretchableButton(
                    text: isEdit ? 'Update' : 'Save',
                    onPressed: () async {
                      if (usernameCtrler.text.trim().isEmpty ||
                          passcodeCtrler.text.trim().isEmpty ||
                          confirmPasscodeCtrler.text.trim().isEmpty) {
                        showToast('Please fill up all fields');
                        return;
                      }

                      if (passcodeCtrler.text.trim() !=
                          confirmPasscodeCtrler.text.trim()) {
                        showToast('Passwords did not match');
                        return;
                      }
                      if (isEdit) {
                        customerProvider.updateWifiUser({
                          'server': mainProvider.server,
                          'userName': usernameCtrler.text,
                          'userPassword': passcodeCtrler.text,
                          'wifiId': wifiId,
                        }, context, () {
                          showToast('New user has been updated successfully');
                          Navigator.pop(context);
                        });
                        return;
                      }
                      customerProvider.addWifiUser({
                        'server': mainProvider.server,
                        'userName': usernameCtrler.text,
                        'userPassword': passcodeCtrler.text
                      }, context, () {
                        showToast('New user has been added successfully');
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                if (isEdit)
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: StretchableButton(
                      text: 'Delete',
                      onPressed: () async {
                        if (usernameCtrler.text.trim().isEmpty ||
                            passcodeCtrler.text.trim().isEmpty ||
                            confirmPasscodeCtrler.text.trim().isEmpty) {
                          showToast('Please fill up all fields');
                          return;
                        }

                        if (passcodeCtrler.text.trim() !=
                            confirmPasscodeCtrler.text.trim()) {
                          showToast('Password did not match');
                          return;
                        }
                        customerProvider.removeWifiUser({
                          'server': mainProvider.server,
                          'userName': usernameCtrler.text,
                          'userPassword': passcodeCtrler.text,
                          'vlanId': customerProvider.currentVlanId,
                          'wifiId': customerProvider.selectedWifiUser.WifiUserID
                        }, context);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
