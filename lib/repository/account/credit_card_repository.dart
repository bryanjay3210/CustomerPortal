import 'package:cp/service/api_request.dart';

class CreditCardRepository extends RequestApi {
  CreditCardRepository(int server) : super(server);

  dynamic getCard(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "GetCard",
      "UserID": map['userId'],
      "LoggedUser": map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic updateCCInfo(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command":"Account",
      "Subcommand1":"NewCard",
      "CardholderName": map['cardholderName'],
      "CardType": map['cardType'],
      "CardNumber": map['cardNumber'],
      "CardCVV": map['cardCVV'],
      "CardExpMonth": map['cardExpMonth'],
      "CardExpYear": map['cardExpYear'],
      "UserID": map['userId'],
      "CardAutobill": map['cardAutobill'],
      "LoggedUser": map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic deleteCard(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command":"Account",
      "Subcommand1":"RemoveCard",
      "CustomerID": map['customerId'],
      "Cardnumber": map['cardNumber'],
      "LoggedUser": map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic futureChargeUpdate(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command":"Account",
      "Subcommand1":"FutureChargeUpdate",
      "CustomerID": map['customerId'],
      "CardAutobill": map['cardAutobill'],
      "LoggedIn": map['loggedIn'],
      "LoggedUser": map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic validateCard(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Account",
      "Subcommand1": "ValidateCard",
      "CardNumber": map['cardNumber'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

}