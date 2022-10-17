import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/manager/building/building_page.dart';
import 'package:cp/view/manager/tv/common_area_tv_page.dart';
import 'package:cp/view/manager/customer/customer_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/iot/home_provider.dart';
import '../provider/login_provider.dart';
import '../provider/main_provider.dart';
import '../shared_widgets/shared_widget.dart';
import 'account/account.dart';
import 'iot/tv/tv_page.dart';
import 'shared_widgets/loading_screen.dart';
import 'iot/home/home_page.dart';
import 'iot/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    //main
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      final hasLocalData =
          await Provider.of<LoginProvider>(context, listen: false)
              .getLocalCredential();

      refresh() async {
        homeProvider.things$.add(false);
        if (hasLocalData != null) {
          await Provider.of<LoginProvider>(context, listen: false).onLogin({
            'username': hasLocalData['username'],
            'password': hasLocalData['password'],
            'server': mainProvider.server,
          }, context, () async {
            await homeProvider.refreshHome(context);
          });
        } else {
          await homeProvider.refreshHome(context);
        }
        homeProvider.things$.add(true);
        setState(() {});
      }

      if (kIsWeb) {
        refresh();
      } else {
        await Provider.of<MainProvider>(context, listen: false)
            .checkConnectivity(() async {
          refresh();
        });
      }
    });

    super.initState();
  }

  static final List<Widget> _pageIot = <Widget>[
    const HomePage(),
    const TvPage(),
    const AccountScreen(),
    const SettingPage(),
  ];

  static final List<Widget> _pageNonIot = <Widget>[
    const AccountScreen(),
    const TvPage(),
    const SettingPage(),
  ];

  static final List<Widget> _pageIsManager = <Widget>[
    const CustomerPage(),
    const BuildingPage(),
    const CommonAreaTvPage(),
    const AccountScreen(),
    const SettingPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavigationBarItemsManager(
      int selected, bool isDarkTheme) {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: badge('account_icon', 'Customer', 0 == selected, isDarkTheme),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('account_icon', 'Building', 1 == selected, isDarkTheme),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('settings_icon', 'Area TV', 2 == selected, isDarkTheme),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('account_icon', 'Account', 3 == selected, isDarkTheme),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('settings_icon', 'Settings', 4 == selected, isDarkTheme),
        label: '',
      ),
    ];
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItemsNonIOT(
      int selected, bool isDarkTheme) {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: badge('account_icon', 'Account', 0 == selected, isDarkTheme),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('tv_icon', 'IPTV', 1 == selected, isDarkTheme, size: 27),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('settings_icon', 'Settings', 2 == selected, isDarkTheme),
        label: '',
      ),
    ];
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItemsIOT(
      int selected, bool isDarkTheme) {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: badge('home_icon', 'Home', 0 == selected, isDarkTheme),
        label: 'test',
      ),
      BottomNavigationBarItem(
        icon: badge('tv_icon', 'IPTV', 1 == selected, isDarkTheme, size: 27),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('account_icon', 'Account', 2 == selected, isDarkTheme),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: badge('settings_icon', 'Settings', 3 == selected, isDarkTheme),
        label: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final navSelected = mainProvider.bottomNavSelected$;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final isManager = mainProvider.isManager();
    final isNoIOT = mainProvider.iot.Status == 'NoIOT';
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<bool>(
            stream: homeProvider.things$,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const LoadingScreen();
              }

              if (snapshot.data == false) {
                return const LoadingScreen();
              }
              return SizedBox(
                child: StreamBuilder<int>(
                    stream: navSelected,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const LoadingScreen();
                      }
                      final selected = snapshot.data;
                      return Scaffold(
                        bottomNavigationBar: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: BottomNavigationBar(
                            backgroundColor:
                                Provider.of<MainProvider>(context).darkTheme
                                    ? cpDarkContainerColor
                                    : cpGreyLightColor,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            selectedFontSize: 0,
                            unselectedFontSize: 0,
                            type: BottomNavigationBarType.fixed,
                            elevation: 20,
                            items: isNoIOT
                                ? isManager
                                    ? _bottomNavigationBarItemsManager(
                                        selected!, mainProvider.darkTheme)
                                    : _bottomNavigationBarItemsNonIOT(
                                        selected!, mainProvider.darkTheme)
                                : _bottomNavigationBarItemsIOT(
                                    selected!, mainProvider.darkTheme),
                            currentIndex: navSelected.value,
                            unselectedItemColor: Colors.grey,
                            onTap: (idx) {
                              if (isNoIOT) {
                                if (isManager) {
                                } else {}
                              } else {}
                              mainProvider.bottomNavSelected$.add(idx);
                            },
                          ),
                        ),
                        body: Center(
                          child: isNoIOT
                              ? isManager
                                  ? _pageIsManager.elementAt(navSelected.value)
                                  : _pageNonIot.elementAt(navSelected.value)
                              : _pageIot.elementAt(navSelected.value),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
