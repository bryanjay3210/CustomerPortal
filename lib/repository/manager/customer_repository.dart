import 'package:flutter/widgets.dart';

import '../../service/api_request.dart';

class CustomerRepository extends RequestApi {
  CustomerRepository(int server) : super(server);

  dynamic updateUserInfo(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "UserInfo",
      "Subcommand1": "Update",
      "UserID": map['userId'],
      "FirstName": map['firstName'],
      "LastName": map['lastName'],
      "ContactPhone": map['contactPhone'],
      "CTPassword": map['ctPassword'],
      "Email": map['email'],
      "PIN": map['pin'],
      "ProductGroupID": '',
      "BedName": map['bedName'],
      "UnitName": map['unitName'],
      "BuildingID": map['buildingId'],
      "loggedUser": map['loggedUser'],
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getUnits(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "SignupPortal",
      "Subcommand1": "UnitList",
      "BuildingID": map["buildingId"],
      "LoggedUser": map["loggedUser"],
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getCustomerInfo(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "CustomerInfo",
      "Subcommand1": "Fetch",
      "CustomerID": map['customerId'],
      "UserID": map['userId']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic removeCustomer(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "CustomerInfo",
      "Subcommand1": "CloseCustomer",
      "CustomerID": map["customerId"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic setEnableOrSuspendCustomer(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "Suspension",
      "CustomerID": map['customerId'],
      //Enabled or Suspend
      "Action": map["action"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic canWifiUser(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Wifi",
      "Subcommand1": "Check",
      "UserID": map["userId"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getWifiUsers(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Wifi",
      "Subcommand1": "List",
      "UserID": map["userId"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getProductBundle(
      Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "ProductGroup",
      "BuildingID": map["buildingId"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getBuilding(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Building",
      "Subcommand1": "Fetch",
      "BuildingID": map["buildingId"],
      'LoggedUser': map['loggedUser']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic createCustomer(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "SignupPortal",
      "Subcommand1": "UserData",
      "FirstName": map['firstName'],
      "LastName": map['lastName'],
      "ContactPhone": map['contactPhone'],
      "CTPassword": map['ctPassword'],
      "Email": map['email'],
      "UnitIdentifier": map['unitIdentifier'],
      "BedName": map['bedName'],
      "PIN": map['pin'],
      "ProductGroupID": map['productGroupId'],
      "PortalName": "Managers"
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic validateEmail(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "SignupPortal",
      "Subcommand1": "ValidateUserName",
      "UserName": map["email"],
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic getCustomers(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "SignupPortal",
      "Subcommand1": "ListCustomers",
      "BuildingID": map["buildingId"]
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic addWifiUser(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Wifi",
      "Subcommand1": "Add",
      "CustomerID": map['customerId'],
      "UserID": map['userId'],
      "UserName": map['userName'],
      "UserPassword": map["userPassword"],
      "UserVLAN": map['userVLan']
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic updateWifiUser(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Wifi",
      "Subcommand1": "Update",
      "CustomerID": map['customerId'],
      "UserID": map['userId'],
      "UserName": map['userName'],
      "UserPassword": map['userPassword'],
      "UserVLAN": map['userVLan'],
      "WifiID": map['wifiId'],
    };
    return await getApi(dataUrl, context: context);
  }

  dynamic removeWifiUser(Map<String, dynamic> map, BuildContext context) async {
    dynamic dataUrl = {
      "Command": "Wifi",
      "Subcommand1": "Remove",
      "CustomerID": map['customerId'],
      "UserID": map['userId'],
      "UserName": map['userName'],
      "UserPassword": map['userPassword'],
      "UserVLAN": map['userVLan'],
      "WifiID": map['wifiId']
    };
    return await getApi(dataUrl, context: context);
  }
}
