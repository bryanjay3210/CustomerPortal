import 'package:cp/service/api_request.dart';

class ProductRepository extends RequestApi {
  ProductRepository(int server) : super(server);

  dynamic getProduct(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Plan",
      "Subcommand1": "List",
      "CustomerID": map['customerId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic getCustomerProduct(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "CustomerProduct",
      "Subcommand1": "List",
      "CustomerID": map['customerId'],
      "PlanID": map['planID'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

}
