import '../constants.dart';

var main_path = (int element) => servers.elementAt(element).values.elementAt(2);
// var pre_prod = () => servers.elementAt(2).values.elementAt(1);
// var prod = () => servers.elementAt(3).values.elementAt(1);
// const main_path = 'https://my.safepayhost.com/';
var server = (int el) => main_path(el) + 'api/api.php?';
var serverIot = (int el) => main_path(el) + 'api/IOTapi.php?';
var serverDvr = (int el) => main_path(el) + 'api/dvrapi.php?';
var serverDoorLock = (int el) => main_path(el) + 'api/lockapi.php?';

String formatAPI(
    {required String dataUrl, String? type, required int serverType}) {
  dataUrl = 'URI=' + dataUrl.replaceAll(r'\', '');
  dataUrl = dataUrl.replaceAll('"', '%22');
  dataUrl = dataUrl.split('{').join('%7B');
  dataUrl = dataUrl.split('}').join('%7D');
  if (type == 'iot') {
    return serverIot(serverType) + dataUrl;
  } else if (type == 'dvr') {
    return serverDvr(serverType == 3 ? 5 : 4) + dataUrl;
  } else if (type == 'lock') {
    print('url: ${server(serverType) + dataUrl}');
    return serverDoorLock(serverType == 3 ? 7 : 6) + dataUrl;
  } else {
    return server(serverType) + dataUrl;
  }
}
