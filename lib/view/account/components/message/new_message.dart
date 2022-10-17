import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/shared_dialog.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../../../../provider/account/address_book_provider.dart';
import '../../../../provider/account/message_provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  List<String> recipient = [];
  List<String> selectedRecipient = [];
  @override
  void initState() {
    final addressBookProvider =
        Provider.of<AddressBookProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    addressBookProvider.getAddressBook({
      'buildingId': mainProvider.user.BuildingID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context).then((_) {
      addressBookProvider.addressBookList.forEach((element) {
        recipient.add(element.Recipient.toString());
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    final subjectCtrl = TextEditingController();
    final messageCtrl = TextEditingController();
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
                    'New Message',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: cpWhiteColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    textField('Subject', subjectCtrl),
                    DropDownMultiSelect(
                      options: recipient.toSet().toList(),
                      selectedValues: selectedRecipient,
                      onChanged: (List<String> x) {
                        setState(() {
                          selectedRecipient = x;
                        });
                      },
                      hint: const Text('Recipient'),
                      hintStyle: TextStyle(
                          fontSize: 13,
                          color: mainProvider.darkTheme
                              ? cpWhiteColor
                              : Colors.black),
                      // whenEmpty: 'Recipient',
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                      ),
                    ),
                    textField('Compose Message', messageCtrl),
                    const SizedBox(height: 10),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [cpPrimaryColor, cpYellowDarkColor])),
                      child: TextButton(
                          onPressed: () async{
                            if(await showConfirmDialog(context, 'Are you sure you want to send this message?')){
                              if(subjectCtrl.text.isEmpty){
                                showToast('Subject is empty!');
                              } else if(selectedRecipient.isEmpty){
                                showToast('Recipient is empty!');
                              } else {
                                messageProvider.sendMessage({
                                  'subject': subjectCtrl.text,
                                  'recipient': selectedRecipient,
                                  'message': messageCtrl.text,
                                  'targetID': '',
                                  'server': mainProvider.server,
                                  'userId': mainProvider.user.UserID,
                                }, context).then((_) {
                                  // showToast(
                                  //     messageProvider.messageStatus.toString());
                                });
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Send',
                                  style: TextStyle(color: cpWhiteColor)),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'assets/images/account/send_logo.svg',
                                width: 18,
                                height: 18,
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textField(
    String label,
    TextEditingController ctrl,
  ) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: const UnderlineInputBorder(),
      ),
      maxLength: label == 'Compose Message' ? 256 : 32,
      maxLines: label == 'Compose Message' ? 5 : 1,
    );
  }
}
