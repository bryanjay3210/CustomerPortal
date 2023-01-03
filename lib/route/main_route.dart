import 'package:cp/view/account/components/message/address_book.dart';
import 'package:cp/view/account/components/billing_address.dart';
import 'package:cp/view/account/components/credit_card.dart';
import 'package:cp/view/account/components/invoices/invoice.dart';
import 'package:cp/view/account/components/message/message_container.dart';
import 'package:cp/view/account/components/message/message_detail.dart';
import 'package:cp/view/account/components/message/message_manager/canned_message_page.dart';
import 'package:cp/view/account/components/message/message_manager/contact_option_page.dart';
import 'package:cp/view/account/components/message/message_manager/message_group_details_page.dart';
import 'package:cp/view/account/components/message/message_manager/send_message.dart';
import 'package:cp/view/account/components/message/message_manager/canned_message_details_page.dart';
import 'package:cp/view/account/components/message/messages.dart';
import 'package:cp/view/account/components/message/new_message.dart';
import 'package:cp/view/account/components/payment.dart';
import 'package:cp/view/account/components/product.dart';
import 'package:cp/view/account/components/transaction.dart';
import 'package:cp/view/account/profile.dart';
import 'package:cp/view/manager/building/door_lock/door_lock_details/door_lock_details_page.dart';
import 'package:cp/view/manager/tv/common_area_tv_details_page.dart';
import 'package:cp/view/manager/tv/common_area_tv_page.dart';
import 'package:cp/view/manager/customer/wifi_user_list_page.dart';
import '../view/account/components/message/main_message.dart';
import '../view/account/components/message/message_manager/message_group.dart';
import '../view/account/components/message/message_manager/message_template.dart';
import '../view/account/components/message/message_manager/message_template_details_page.dart';
import '../view/iot/home/home_page.dart';
import '../view/main_page.dart';
import '../view/iot/pair_page.dart';
import '../view/iot/room/room_manager_page.dart';
import '../view/iot/room/room_update_page.dart';
import '../view/iot/scene/scene_manager_page.dart';
import '../view/iot/schedule/schedule_detail_page.dart';
import '../view/iot/schedule/schedule_page.dart';
import '../view/iot/setting_page.dart';
import '../view/login_page.dart';
import '../view/inital_page.dart';
import '../view/manager/building/building_page.dart';
import '../view/manager/customer/customer_details_page.dart';
import '../view/manager/customer/customer_page.dart';

dynamic routes() {
  return {
    '/': (context) => const InitialPage(),
    'main': (context) => const MainPage(),
    'login': (context) => const LoginPage(),
    'home': (context) => const HomePage(),
    'settings': (context) => const SettingPage(),
    'schedule': (context) => const SchedulePage(),
    'pair': (context) => const PairPage(),
    'scene_management': (context) => const SceneManagerPage(),
    'room_management': (context) => const RoomManagerPage(),
    'room_update': (context) => const RoomUpdatePage(),
    'schedule_detail': (context) => const ScheduleDetailPage(),
    'profile': (context) => const Profile(),
    'product': (context) => const ProductScreen(),
    'payment': (context) => const PaymentScreen(),
    'invoice': (context) => const InvoiceScreen(),
    'transaction': (context) => const TransactionScreen(),
    'credit_card': (context) => const CreditCardScreen(),
    'billing_address': (context) => const BillingAddress(),
    'address_book': (context) => const AddressBook(),
    'messages': (context) => const Messages(),
    'message_container': (context) => const MessageContainer(),
    'message_detail': (context) => const MessageDetailPage(),
    'new_message': (context) => const NewMessage(),
    'main_message': (context) => const MainMessageScreen(),

    //screens for managers
    'customer': (context) => const CustomerPage(),
    'customer_details': (context) => const CustomerDetailsPage(),
    'building': (context) => const BuildingPage(),
    'common_area_tv': (context) => const CommonAreaTvPage(),
    'common_area_tv_detail': (context) => const CommonAreaTvDetailsPage(),
    'wifi_user_list': (context) => const WifiUserListPage(),
    'message_group': (context) => const MessageGroupPage(),
    'message_group_detail': (context) => const MessageGroupDetailsPage(),
    'message_template': (context) => const MessageTemplatePage(),
    'message_template_detail': (context) => const MessageTemplateDetailsPage(),
    'send_message': (context) => const SendMessagePage(),
    'canned_message': (context) => const CannedMessagePage(),
    'canned_message_detail': (context) => const CannedMessageDetailsPage(),
    'contact_option': (context) => const ContactOptionPage(),
    'door_lock_details_manager': (context) => const DoorLockDetailsPage(),
  };
}
