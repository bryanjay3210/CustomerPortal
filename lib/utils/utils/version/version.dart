import 'package:package_info_plus/package_info_plus.dart';

Future<String> getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return 'v${packageInfo.version} B${packageInfo.buildNumber}';
}