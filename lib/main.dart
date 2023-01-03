import 'package:cp/provider/account/message_group_provider.dart';
import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:cp/provider/manager/contact_option_provider.dart';
import 'package:cp/provider/iot/door_lock/door_lock_password_provider.dart';
import 'package:cp/provider/iot/door_lock/door_lock_provider.dart';
import 'package:cp/utils/utils/theme/global_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'constants.dart';
import 'provider/account/account_provider.dart';
import 'provider/account/address_book_provider.dart';
import 'provider/account/credit_card_provider.dart';
import 'provider/account/invoice_provider.dart';
import 'provider/account/message_manager/canned_message.dart';
import 'provider/account/message_manager/message_template.dart';
import 'provider/account/message_manager/send_message.dart';
import 'provider/account/message_provider.dart';
import 'provider/account/payment_provider.dart';
import 'provider/account/product_provider.dart';
import 'provider/account/profile_provider.dart';
import 'provider/account/transaction_provider.dart';
import 'provider/initial_provider.dart';
import 'provider/iot/home_provider.dart';
import 'provider/iot/scene_management_provider.dart';
import 'provider/iot/tv_provider.dart';
import 'provider/login_provider.dart';
import 'provider/main_provider.dart';
import 'provider/manager/building_provider.dart';
import 'provider/manager/common_tv_provider.dart';
import 'provider/manager/customer_provider.dart';
import 'provider/iot/pair_provider.dart';
import 'provider/iot/schedule_provider.dart';
import 'route/main_route.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.openBox('user_pass');
  await Hive.openBox('home_provider');

  // await setPreferredOrientations();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...providers()],
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            final mainProvider =
                Provider.of<MainProvider>(context, listen: false);
            return FutureBuilder(
              future: getTheme(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  mainProvider.darkTheme = snapshot.data;
                }
                return StreamBuilder<bool>(
                    stream: mainProvider.isDark,
                    builder: (context, snapshot) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        key: mainKey,
                        title: 'Customer Portal',
                        initialRoute: '/',
                        routes: routes(),
                        theme: mainProvider.darkTheme
                            ? GlobalTheme.buildDarkTheme()
                            : GlobalTheme.buildLightTheme(),
                      );
                    });
              },
            );
          },
        );
      }),
    );
  }
}

Future<bool> getTheme() async {
  return await MainProvider().appPreference.getTheme();
}

List<SingleChildWidget> providers() {
  return [
    Provider<InitialProvider>(create: (_) => InitialProvider()),
    Provider<MainProvider>(create: (_) => MainProvider()),
    Provider<LoginProvider>(create: (_) => LoginProvider()),
    Provider<AccountProvider>(create: (_) => AccountProvider()),
    Provider<HomeProvider>(create: (_) => HomeProvider()),
    Provider<PairProvider>(create: (_) => PairProvider()),
    Provider<SceneManagementProvider>(create: (_) => SceneManagementProvider()),
    Provider<ScheduleProvider>(create: (_) => ScheduleProvider()),
    Provider<InvoiceProvider>(create: (_) => InvoiceProvider()),
    Provider<TransactionProvider>(create: (_) => TransactionProvider()),
    Provider<ProductProvider>(create: (_) => ProductProvider()),
    Provider<ProfileProvider>(create: (_) => ProfileProvider()),
    Provider<CreditCardProvider>(create: (_) => CreditCardProvider()),
    Provider<PaymentProvider>(create: (_) => PaymentProvider()),
    Provider<AddressBookProvider>(create: (_) => AddressBookProvider()),
    Provider<MessageProvider>(create: (_) => MessageProvider()),
    Provider<TvProvider>(create: (_) => TvProvider()),
    Provider<MessageGroupListProvider>(
        create: (_) => MessageGroupListProvider()),
    Provider<DoorLockProvider>(create: (_) => DoorLockProvider()),
    Provider<DoorLockProvider>(create: (_) => DoorLockProvider()),
    Provider<DoorLockPasswordProvider>(
        create: (_) => DoorLockPasswordProvider()),

    //manager providers
    Provider<CustomerProvider>(create: (_) => CustomerProvider()),
    Provider<BuildingProvider>(create: (_) => BuildingProvider()),
    Provider<CommonTvProvider>(create: (_) => CommonTvProvider()),
    Provider<MessageGroupProvider>(create: (_) => MessageGroupProvider()),
    Provider<MessageTemplateProvider>(create: (_) => MessageTemplateProvider()),
    Provider<SendMessageProvider>(create: (_) => SendMessageProvider()),
    Provider<CannedMessageProvider>(create: (_) => CannedMessageProvider()),
    Provider<ContactOptionProvider>(create: (_) => ContactOptionProvider())
  ];
}
