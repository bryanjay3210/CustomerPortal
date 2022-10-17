import 'package:cp/provider/account/message_provider.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/shared_dialog.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({Key? key}) : super(key: key);

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  @override
  void initState() {
   Future.delayed(const Duration(seconds: 1), () {
     final messageProvider =
     Provider.of<MessageProvider>(context, listen: false);
     final mainProvider = Provider.of<MainProvider>(context, listen: false);
     Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
     messageProvider.changeMessageStatus(
         {
           'messageID': arguments['messageId'],
           'newStatus': 'A',
           'userId': mainProvider.user.UserID,
           'server': mainProvider.server,
         }, context);
   });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final messageProvider =
    Provider.of<MessageProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: const Color(0xff30313A),
      body: Column(
        children: [
          Container(
            color: const Color(0xff30313A),
            width: double.infinity,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: cpWhiteColor)),
                  const SizedBox(height: 30),
                  const Text(
                    'Message',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: cpWhiteColor),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/account/contact_logo.svg',
                        width: 30, height: 30),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(arguments['subject'],
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    const SizedBox(
                      width: 3,
                    ),
                    SizedBox(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffE0F7FB)),
                              width: double.infinity,
                              height: 20,
                              child: Center(
                                  child: Text(arguments['date'],
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: mainProvider.darkTheme
                                              ? Colors.black
                                              : cpDarkBgColor))),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(arguments['time'],
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: mainProvider.darkTheme
                        ? const Color(0xff3C3F41)
                        : const Color(0xfff5f5f5),
                  ),
                  child: Text(
                    arguments['message'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () async{
                         if(await showConfirmDialog(context, 'Are you sure you want to delete this message?')){
                          messageProvider.changeMessageStatus({
                                        'messageID': arguments['messageId'],
                                        'newStatus': 'D',
                                        'userId': mainProvider.user.UserID,
                                        'server': mainProvider.server,
                                      }, context).then((_) {
                                        Navigator.of(context).pop();
                                      });
                         }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Delete Message',
                              style: TextStyle(color: cpWhiteColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.delete,
                              color: cpWhiteColor,
                              size: 20,
                            )
                          ],
                        ))),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
