import 'package:cp/service/api_request.dart';

class InvoiceRepository extends RequestApi {
  InvoiceRepository(int server) : super(server);

  dynamic getInvoiceDetails(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "InvoiceDetail",
      "InvoiceID": map['invoiceId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic getInvoiceInfo(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Invoice",
      "Subcommand1": "List",
      "CustomerID": map['customerId'],
      "Search" : map['search'],
      "Page": map['page'],
      "PerPage":"10",
      "SortBy":"InvoiceIssueDate",
      "SortType":"DESC",
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic sendInvoiceToEmail(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "EmailInvoice",
      "InvoiceID": map['invoiceId'],
      "UserID": map['usedId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic getCustomer(Map<String, dynamic> map) async{
    dynamic dataUrl = {
      'Command': 'CustomerInfo',
      'Subcommand1': 'Fetch',
      'CustomerID': map['customerId'],
      'UserID': map['userId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic updateCustomerInfo(Map<String, dynamic> map) async{
    dynamic dataUrl = {
      "Command":"CustomerInfo",
      "Subcommand1":"UpdateLocation",
      "UserID": map['userId'],
      "GUID": map['gUID'],
      "CustomerID": map['customerID'],
      "LocationType": 'Billing',
      "LocationID": map['locationID'],
      "AddressNumber": map['addressNumber'],
      "StreetDirection": map['streetDirection'],
      "StreetName": map['streetName'],
      "StreetSuffix": map['streetSuffix'],
      "AddressSuffix": map['addressSuffix'],
      "City": map['city'],
      "State": map['state'],
      "Country":"United States",
      "Zip": map['zip'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic getBalance(Map<String, dynamic> map) async{
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "Balance",
      "CustomerID": map['customerId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

}