import 'package:cp/service/api_request.dart';

class PaymentRepository extends RequestApi {
  PaymentRepository(int server) : super(server);

  dynamic getCard(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "GetCard",
      "UserID": map['userId'],
      "InvoiceID": map['invoiceId'],
      "Auth": map['auth'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic makePayment(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "MakePayment",
      "Subcommand2": map['paymentOption'],
      "CustomerID": map['customerID'],
      "User": map['userId'],
      "Auth": map['auth'],
      "InvoiceID": map['invoiceID'],
      "PaymentMethod": "Authorizedotnet",
      "PaymentAmount": map['paymentAmount'],
      "ReferenceNumber":"",
      "UseStoredCard": map['useStoredCard'],
      "CardholderName": map['cardholderName'],
      "CardNumber": map['cardNumber'],
      "CardType": map['cardType'],
      "CardExpDate": map['cardExpDate'],
      "CVV": map['cVV'],
      "StoreCard": map['storeCard'],
      "CardAutobill": map['cardAutobill'],
      "UseCreditBalance": 'N',
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic getInvoiceInfo(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "Invoices",
      "CustomerID": map['customerId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getPlans(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Plan",
      "Subcommand1": "List",
      "CustomerID": map['customerId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic validateCard(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "ValidateCard",
      "CardNumber": map['cardNumber'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

  dynamic getPaymentMethod(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "DefaultProcessor",
      "CustomerID": map['customerId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

}
