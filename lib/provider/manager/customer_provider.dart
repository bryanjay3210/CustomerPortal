import 'package:cp/model/unit_info/unit_info.dart';
import 'package:cp/model/wifi_user/wifi_user.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import '../../enum.dart';
import '../../model/product_group/product/product.dart';
import '../../model/product_group/product_group.dart';
import '../../model/unit/unit.dart';
import '../../repository/manager/customer_repository.dart';
import '../../shared_widgets/toasts.dart';
import '../../utils/utils/on_type_functions/debouncer.dart';
import '../main_provider.dart';

class CustomerProvider {
  var customers = <UnitInfo>[];
  var allCustomers = <UnitInfo>[];
  var wifiUsers = <WifiUser>[];
  var allWifiUsers = <WifiUser>[];
  var productBundles = <ProductGroup>[];
  var selectedProductBundles = ProductGroup();
  var units = <Unit>[];
  var selectedUnits = Unit();
  var selectedBed = '';
  final customers$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final customerInfo$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final suspend$ = BehaviorSubject<bool>.seeded(false);
  final wifiUsers$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final canWifiUser$ = BehaviorSubject<bool>.seeded(false);
  // final productBundle$ = BehaviorSubject<List<String>>.seeded([]);
  final _filterDebounce = Debouncer(delay: const Duration(milliseconds: 1500));
  var selectedCustomer = UnitInfo();
  var selectedWifiUser = WifiUser();
  var currentVlanId = '';
  get getSuspend => suspend$.value;
  var currentCustomerSearch = '';
  var keywordSearch = '';

  getCustomers(Map<String, dynamic> map, BuildContext context) async {
    customers$.add(DataState.loading);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).getCustomers(map, context);
    final newItems = <UnitInfo>[];
    if (data['Status'] == "Success") {
      if (data['UnitInfo'] == null) {
        customers$.add(DataState.empty);
        return;
      } else if (data['UnitInfo'] is Map) {
        newItems.add(UnitInfo.fromJson(data['UnitInfo']));
      } else {
        data['UnitInfo'].forEach((element) {
          if (element['BedName'] is Map) {
            element['BedName'] = '';
          }
          if (element['UserFname'] is Map) {
            element['UserFname'] = '';
          }
          if (element['UserLname'] is Map) {
            element['UserLname'] = '';
          }
          if (element['customerName'] is Map) {
            element['customerName'] = '';
          }

          newItems.add(UnitInfo.fromJson(element));
        });
      }
      customers = newItems;
      allCustomers = newItems;
      customers$.add(DataState.success);
    } else {
      customers$.add(DataState.success);
    }
  }

  populateDropDowns() {
    selectedProductBundles = productBundles[0];
    selectedUnits = units[0];
  }

  getWifiUsers(Map<String, dynamic> map, BuildContext context) async {
    wifiUsers$.add(DataState.loading);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).getWifiUsers(map, context);
    final newItems = <WifiUser>[];
    if (data['Status'] == "Success") {
      if (data['WifiUsers'] == null) {
        wifiUsers$.add(DataState.empty);
        return;
      } else if (data['WifiUsers'] is Map) {
        newItems.add(WifiUser.fromJson(data['WifiUsers']));
      } else {
        data['WifiUsers'].forEach((element) {
          newItems.add(WifiUser.fromJson(element));
        });
      }
      currentVlanId = data['VlanID'] ?? '';
      wifiUsers = newItems;
      allWifiUsers = newItems;
      wifiUsers$.add(DataState.success);
    } else {
      currentVlanId = '';
      wifiUsers$.add(DataState.success);
    }
  }

  filterWifiUsers(String text) {
    wifiUsers$.add(DataState.loading);
    _filterDebounce.run(() {
      if (text.trim().isEmpty) {
        wifiUsers = allWifiUsers;
        customers$.add(DataState.success);
        return;
      }
      wifiUsers = [
        ...allWifiUsers.where((element) =>
            element.WifiUserName.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.WifiUserID.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()))
      ];

      if (wifiUsers.isEmpty) {
        wifiUsers$.add(DataState.empty);
      } else {
        wifiUsers$.add(DataState.success);
      }
    });
  }

  filterCustomers(String text) {
    currentCustomerSearch = text;
    customers$.add(DataState.loading);
    _filterDebounce.run(() {
      if (text.trim().isEmpty) {
        customers = allCustomers;
        customers$.add(DataState.success);
        return;
      }
      customers = [
        ...allCustomers.where((element) =>
            element.UnitName.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.CustomerName.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.UserFname.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.UserLname.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()) ||
            element.CustomerID.toString()
                .toLowerCase()
                .trim()
                .contains(text.toLowerCase().trim()))
      ];
      if (customers.isEmpty) {
        customers$.add(DataState.empty);
      } else {
        customers$.add(DataState.success);
      }
    });
  }

  setEnableOrSuspendCustomer(
      Map<String, dynamic> map, BuildContext context) async {
    // suspend$.add(DataState.loading);
    map['customerId'] = selectedCustomer.CustomerID;
    map['action'] =
        selectedCustomer.Suspended.toString() == 'Y' ? 'Enable' : 'Suspend';
    Map<String, dynamic> data = await CustomerRepository(map['server'])
        .setEnableOrSuspendCustomer(map, context);
    if (data['Status'] == 'Success') {
      for (var i = 0; i < allCustomers.length; i++) {
        if (allCustomers[i].CustomerID == map['customerId']) {
          final newCustomer = allCustomers[i].copyWith(
              Suspended: allCustomers[i].Suspended == 'Y' ? 'N' : 'Y');
          allCustomers[i] = newCustomer;
        }
      }
      selectedCustomer = selectedCustomer.copyWith(
          Suspended: selectedCustomer.Suspended == 'Y' ? 'N' : 'Y');
      customers = allCustomers;
      suspend$.add(!suspend$.value);
      customers$.add(DataState.success);
      showToast('Status Successfully Updated');
    } else {}
  }

  updateCustomer(
      Map<String, dynamic> map, BuildContext context, dynamic func) async {
    customerInfo$.add(DataState.loading);
    map['userId'] = selectedCustomer.UserID;
    map['loggedUser'] =
        Provider.of<MainProvider>(context, listen: false).user.UserID;

    if (selectedCustomer.UserEmail.toString().toLowerCase().trim() !=
        map['email'].toString().toLowerCase().trim()) {
      Map<String, dynamic> data2 =
          await CustomerRepository(map['server']).validateEmail(map, context);
      if (data2['Status'] == 'Duplicate') {
        showToast('Your email is already registered');
        return;
      }
    }

    Map<String, dynamic> data =
        await CustomerRepository(map['server']).updateUserInfo(map, context);

    if (data['Status'] == 'Success') {
      final idx = allCustomers.indexWhere(
          (element) => element.UserID.toString() == map['userId'].toString());
      allCustomers[idx] = allCustomers[idx].copyWith(
          UserFname: map['firstName'],
          UserLname: map['lastName'],
          UserPhoneMobile: map['contactPhone'],
          CustomerPin: map['pin'],
          UserEmail: map['email']);
      filterCustomers(currentCustomerSearch);
      customers$.add(DataState.success);
      showToast('The customer has been successfully updated');
      Navigator.pop(context);
    } else {}
    customerInfo$.add(DataState.success);
    func();
  }

  createCustomer(
      Map<String, dynamic> map, BuildContext context, dynamic func) async {
    customerInfo$.add(DataState.loading);
    map['userId'] = selectedCustomer.UserID;

    Map<String, dynamic> data2 =
        await CustomerRepository(map['server']).validateEmail(map, context);
    if (data2['Status'] == 'Duplicate') {
      showToast('Your email is already registered');
      customerInfo$.add(DataState.success);
      return;
    }

    Map<String, dynamic> data =
        await CustomerRepository(map['server']).createCustomer(map, context);

    if (data['Status'] == 'Success') {
      UnitInfo(
          UserFname: map['firstName'],
          UserLname: map['lastName'],
          UserPhoneMobile: map['contactPhone'],
          CustomerPin: map['pin'],
          UserEmail: map['email']);
      await Future.delayed(const Duration(milliseconds: 1500));
      await getCustomers(map, context);
      customers$.add(DataState.success);
      customerInfo$.add(DataState.success);
      Navigator.pop(context);
      showToast('The customer has been successfully created');
    } else if (data['Status'] == 'Fail-5001 Password already in use') {
      showToast('Password is already in use');

      customerInfo$.add(DataState.success);
      // return;
    } else {
      customerInfo$.add(DataState.success);
      // suspend$.add(DataState.success);
    }
    func();
  }

  removeCustomer(Map<String, dynamic> map, BuildContext context) async {
    customers$.add(DataState.loading);
    map['customerId'] = selectedCustomer.CustomerID;
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).removeCustomer(map, context);
    if (data['Status'] == 'Success') {
      allCustomers
          .removeWhere((element) => element.CustomerID == map['customerId']);
      customers = allCustomers;

      showToast('the customer has been successfully deleted');
      Navigator.pop(context);
    } else {}
    customers$.add(DataState.success);
  }

  addWifiUser(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    map['userVLan'] = currentVlanId;
    map['customerId'] = selectedCustomer.CustomerID;
    map['userId'] = selectedCustomer.UserID;

    wifiUsers$.add(DataState.loading);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).addWifiUser(map, context);
    if (data['Status'] == 'Success') {
      getWifiUsers(map, context);
      if (callback != null) {
        callback();
      }
      wifiUsers$.add(DataState.success);
    } else {
      wifiUsers$.add(DataState.error);
    }
  }

  updateWifiUser(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    map['userVLan'] = currentVlanId;
    map['customerId'] = selectedCustomer.CustomerID;
    map['userId'] = selectedCustomer.UserID;

    wifiUsers$.add(DataState.loading);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).updateWifiUser(map, context);
    if (data['Status'] == 'Success') {
      getWifiUsers(map, context);
      if (callback != null) {
        callback();
      }
      wifiUsers$.add(DataState.success);
    } else {
      wifiUsers$.add(DataState.success);
    }
  }

  removeWifiUser(Map<String, dynamic> map, BuildContext context) async {
    wifiUsers$.add(DataState.loading);
    map['customerId'] = selectedCustomer.CustomerID;
    map['userId'] = selectedCustomer.UserID;
    // map['']
    // selectedCustomer.
    map['vlanId'] = currentVlanId;
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).removeWifiUser(map, context);
    getWifiUsers(map, context);
    if (data['Status'] == 'Success') {
      showToast('the customer has been successfully deleted');
      Navigator.pop(context);
    } else {}
    wifiUsers$.add(DataState.success);
  }

  canWifiUser(Map<String, dynamic> map, BuildContext context) async {
    canWifiUser$.add(false);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).canWifiUser(map, context);
    if (data['Status'] == "Success") {
      if (data['Enabled'] == 'No') {
        canWifiUser$.add(false);
        return;
      }

      currentVlanId = data['VlanID'] ?? '';
      canWifiUser$.add(true);
    }
  }

  getCustomerInfo(
      Map<String, dynamic> map, BuildContext context, bool isCreate) async {
    customerInfo$.add(DataState.loading);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).getCustomerInfo(map, context);

    if (data['Status'] == "Success") {
      // map['buildingId'] = map;
      final info = UnitInfo.fromJson(data).copyWith(
          UserPhoneMobile: data['User']['UserPhoneMobile'] is Map
              ? ''
              : data['User']['UserPhoneMobile'],
          CustomerPin: data['CustomerPIN'] is Map ? '' : data['CustomerPIN'],
          UserEmail: data['User']['UserEmail'] is Map
              ? ''
              : data['User']['UserEmail']);
      if (isCreate) {
        final newCustomer = selectedCustomer.copyWith(
          BuildingName: info.BuildingName,
        );
        selectedCustomer = newCustomer;
        selectedBed = newCustomer.BedName;
      } else {
        final newCustomer = selectedCustomer.copyWith(
            BuildingName: info.BuildingName,
            UserEmail: info.UserEmail,
            CustomerPin: info.CustomerPin,
            UserPhoneMobile: info.UserPhoneMobile);

        selectedCustomer = newCustomer;
        selectedBed = newCustomer.BedName;
      }
      await getUnits(map, context);
    }
    if (keywordSearch.isNotEmpty) {
      filterCustomers(keywordSearch);
    } else {}
    customerInfo$.add(DataState.success);
  }

  getProductBundles(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).getProductBundle(map, context);
    final newItems = <ProductGroup>[];
    newItems.add(ProductGroup(Products: <Product>[]));
    if (data['Status'] == "Success") {
      if (data['ProductGroup'] == null) {
        return;
      } else if (data['ProductGroup'] is Map) {
        newItems.add(ProductGroup.fromJson(data['ProductGroup']).copyWith(
            Products: <Product>[
              ...data['Product'].map((x) => Product.fromJson(x)).toList()
            ]));
      } else {
        data['ProductGroup'].forEach((element) {
          final newItem2 = <Product>[];
          if (element['Product'] == null) {
          } else if (element['Product'] is Map) {
            newItem2.add(Product.fromJson(element['Product']));
          } else {
            element['Product'].forEach((element2) {
              newItem2.add(Product.fromJson(element2));
            });
          }
          newItems
              .add(ProductGroup.fromJson(element).copyWith(Products: newItem2));
        });
      }

      productBundles = newItems;
    }
  }

  getUnits(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).getUnits(map, context);
    final newItems = <Unit>[];
    newItems.add(Unit());
    if (data['Status'] == "Success") {
      if (data['Unit'] == null) {
        customers$.add(DataState.empty);
        return;
      } else if (data['Unit'] is Map) {
        newItems.add(Unit.fromJson(data['Unit']));
      } else {
        data['Unit'].forEach((element) {
          newItems.add(Unit.fromJson(element));
        });
      }
      units = newItems;
      populateDropDowns();
    }
  }

  // bool isAvailableInCustomers() {
  //   productBundles.where((element) {
  //       return element.CustomerAvailable.toString() == 'Y' ||
  //           element.CustomerAvailable.toString() != '' ||
  //           element.CustomerAvailable != null;
  //     })
  //   return true;
  // }

  List<ProductGroup> getFilteredProductGroup(bool isAvailableInCustomers) {
    return [
      ProductGroup(Products: <Product>[]),
      ...productBundles.where((element) {
        return (isAvailableInCustomers
                ? element.CustomerAvailable.toString() == 'Y'
                : element.CustomerAvailable.toString() == 'N') &&
            element.CustomerAvailable.toString() != '' &&
            element.CustomerAvailable != null;
      }),
    ];
  }
}
