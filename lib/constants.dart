import 'dart:ui';

import 'package:flutter/widgets.dart';

final currentDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

final mqHeight = (BuildContext context) => MediaQuery.of(context).size.height;
final mqWidth = (BuildContext context) => MediaQuery.of(context).size.width;

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

bool isDesktopSize(BuildContext context) {
  return mqWidth(context) / mqHeight(context) > 1.4;
}

final GlobalKey mainKey = GlobalKey();

const servers = [
  {
    'name': 'dev',
    'label': 'Development',
    'server': 'https://devnyc001.acebill.net/'
  },
  {'name': 'test', 'label': 'Test', 'server': 'https://devnyc001.acebill.net/'},
  {
    'name': 'pre-prod',
    'label': 'Pre-Production',
    'server': 'http://pre-prod1.acebill.net:443/'
  },
  {
    'name': 'prod',
    'label': 'Production',
    'server': 'https://my.safepayhost.com/'
  },
  {
    'name': 'dvr-dev',
    'labe': 'DVR Development',
    'server': 'http://devdvr.acebill.net:8088/'
  },
  {
    'name': 'dvr-prod',
    'labe': 'DVR Production',
    'server': 'https://api.iptv.safepayhost.com:8088/'
  },
  {
    'name': 'lock-dev',
    'labe': 'DVR Development',
    'server': 'http://devnyc001.acebill.net:8088/'
  },
  {
    'name': 'lock-prod',
    'labe': 'DVR Production',
    'server': 'https://devnyc001.acebill.net:8088/'
  },
];

// https://api.iptv.safepayhost.com:8088
// http://devdvr.acebill.net:8088/api/dvrapi.php?URI

const sceneIcon = [
  {'SceneName': 'Asleep', 'icon': 'images/home/scene/asleep_icon'},
  {'SceneName': 'Away', 'icon': 'images/home/scene/away_icon'},
  {'SceneName': 'Home', 'icon': 'images/home/scene/home_icon'},
  {'SceneName': 'Custom', 'icon': 'images/home/scene/custom_icon'},
  {'SceneName': 'Add', 'icon': 'images/home/scene/add_more'},
];

const systemModeMap = ['heat', 'cool', 'auto', 'off'];

const dayList = ['1', '2', '3', '4', '5', '6', '7'];

const aptStatus = ['Vacant', 'Occupied', 'Disabled'];
