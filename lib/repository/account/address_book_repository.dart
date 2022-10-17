import 'package:cp/service/api_request.dart';

class AddressBookRepository extends RequestApi {
  AddressBookRepository(int server) : super(server);

  dynamic getAddressBook(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "Message",
      "Subcommand1": "AddressBook",
      "BuildingID": map['buildingId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl, type: 'iot');
  }

}