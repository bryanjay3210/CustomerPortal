import 'package:cp/service/api_request.dart';

class TransactionRepository extends RequestApi {
  TransactionRepository(int server) : super(server);

  dynamic getTransaction(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command":"Account",
      "Subcommand1":"Transactions",
      "CustomerID": map['customerId'],
      'Search' : map['search'],
      'Page': '1',
      'PerPage': '500',
      'SortBy': 'TXNID',
      'SortType': 'DESC',
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }
}
