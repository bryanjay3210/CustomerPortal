import 'package:cp/service/api_request.dart';

class ProfileRepository extends RequestApi {
  ProfileRepository(int server) : super(server);

  dynamic getProfile(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "UserInfo",
      "Subcommand1": "Fetch",
      "CustomerID": map['customerId'],
      "UserID": map['userId'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic updateProfile(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "UserInfo",
      "Subcommand1": "Update",
      "CustomerID": map['customerId'],
      "UserID": map['userId'],
      "GUID": map['gUID'],
      "CTPassword": map['password'],
      "UserPhoneHome": map['userPhoneHome'],
      "UserPhoneWork": map['userPhoneWork'],
      "UserPhoneCell": map['userPhoneCell'],
      "FirstName" : map['firstName'],
      "LastName" : map['lastName'],
      "UserEmail": map['userEmail'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

  dynamic validateEmail(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Command": "SignupPortal",
      "Subcommand1": "ValidateUserName",
      "UserName": map['emailAddress'],
      'LoggedUser': map['userId'],
    };
    return await getApi(dataUrl);
  }

}
