import 'package:cp/repository/manager/contact_option_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../enum.dart';
import '../../model/contact_provider/contact_provider.dart';
import '../../model/customer_message_group/customer_message_group.dart';
import '../../shared_widgets/toasts.dart';
import '../main_provider.dart';

class ContactOptionProvider {
  final contactOption$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final getCustomerInfo$ =
      BehaviorSubject<ButtonState>.seeded(ButtonState.loaded);
  var currentCustomer = CustomerMessageGroup();
  var currentProvider = ContactProvider();
  var providers = <ContactProvider>[];

  getProviders(Map<String, dynamic> map, BuildContext context) async {
    contactOption$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['loggedUser'] = mainProvider.user.UserID;

    Map<String, dynamic> data =
        await ContactOptionRepository(int.parse(map['server']))
            .getCellProviders(map, context);
    final newItems = <ContactProvider>[];
    if (data['Status'] == "Success") {
      if (data['Providers'] == null) {
        contactOption$.add(DataState.empty);
        return;
      } else if (data['Providers'] is Map) {
        newItems.add(ContactProvider.fromJson(data['Providers']));
      } else {
        data['Providers'].forEach((element) {
          newItems.add(ContactProvider.fromJson(element));
        });
      }
      newItems.sort((a, b) =>
          a.ProviderName.toLowerCase().compareTo(b.ProviderName.toLowerCase()));
      providers = newItems;
    } else {}
    contactOption$.add(DataState.success);
  }

  getContactOption(
      Map<String, dynamic> map, BuildContext context, dynamic run) async {
    getCustomerInfo$.add(ButtonState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data = await ContactOptionRepository(map['server'])
        .getContactOption(map, context);
    if (data['Status'] == "Success") {
      currentProvider = ContactProvider.fromJson(data['ContactOption']);
      run();
      getCustomerInfo$.add(ButtonState.loaded);
    }
    // contactOption$.add(DataState.success);
  }

  createContactOption(
    Map<String, dynamic> map,
    BuildContext context,
    dynamic run,
  ) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    map['cellProviderId'] =
        map['smsDelivery'] == 'Y' ? currentProvider.ProviderID : '';
    print(map['cellProviderId']);
    Map<String, dynamic> data = await ContactOptionRepository(map['server'])
        .createContactOption(map, context);
    if (data['Status'] == "Success") {
      showToast('Contact Option Saved Successfully');
    }

    run();
  }
}
