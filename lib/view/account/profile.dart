import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/account/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final emailAddessCtrler = TextEditingController();
  final homePhoneCtrler = TextEditingController();
  final workPhoneCtrler = TextEditingController();
  final mobilePhoneCtrler = TextEditingController();
  final passwordCtrler = TextEditingController();
  final confirmPasswordCtrler = TextEditingController();
  String lastName = '';
  String firstName = '';
  String userName = '';
  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.emailHasDuplicate.add(false);
    firstName = profileProvider.profile[0].UserFirstName.isEmpty
        ? ''
        : profileProvider.profile[0].UserFirstName.toString();
    lastName = profileProvider.profile[0].UserLastName.isEmpty
        ? ''
        : profileProvider.profile[0].UserLastName.toString();
    emailAddessCtrler.text =
        profileProvider.profile[0].UserEmail.isEmpty
            ? ''
            : profileProvider.profile[0].UserEmail.toString();
    homePhoneCtrler.text =
        profileProvider.profile[0].UserPhoneHome.isEmpty
            ? ''
            : profileProvider.profile[0].UserPhoneHome.toString();
    workPhoneCtrler.text =
        profileProvider.profile[0].UserPhoneWork.isEmpty
            ? ''
            : profileProvider.profile[0].UserPhoneWork.toString();
    mobilePhoneCtrler.text =
        profileProvider.profile[0].UserPhoneMobile.isEmpty
            ? ''
            : profileProvider.profile[0].UserPhoneMobile.toString();
    passwordCtrler.text = '';
    confirmPasswordCtrler.text = '';
    userName = profileProvider.profile[0].UserName.isEmpty
        ? ''
        : profileProvider.profile[0].UserName.toString();
    super.initState();
  }

  @override
  void dispose() {
    emailAddessCtrler.dispose();
    homePhoneCtrler.dispose();
    workPhoneCtrler.dispose();
    mobilePhoneCtrler.dispose();
    passwordCtrler.dispose();
    confirmPasswordCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color(0xff30313A),
                width: double.infinity,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
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
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: cpWhiteColor),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('First Name',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(firstName, style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Last Name',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(lastName, style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Username',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(userName, style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 15,
                    ),
                    textFieldWidget('Email Address', '', emailAddessCtrler,
                        false, false, true),
                    const SizedBox(
                      height: 15,
                    ),
                    textFieldWidget(
                        'Home Phone', '', homePhoneCtrler, false, true, false),
                    const SizedBox(
                      height: 15,
                    ),
                    textFieldWidget(
                        'Work Phone', '', workPhoneCtrler, false, true, false),
                    const SizedBox(
                      height: 15,
                    ),
                    textFieldWidget('Mobile Phone', '', mobilePhoneCtrler,
                        false, true, false),
                    const SizedBox(
                      height: 15,
                    ),
                    textFieldWidget(
                        'Password', '', passwordCtrler, false, false, false),
                    const SizedBox(
                      height: 15,
                    ),
                    textFieldWidget('Confirm Password', '',
                        confirmPasswordCtrler, false, false, false),
                    const SizedBox(
                      height: 15,
                    ),
                    buttonContainer(
                        text: 'Update Profile',
                        onPress: () async {
                          if (passwordCtrler.text ==
                              confirmPasswordCtrler.text) {
                            if (profileProvider.emailHasDuplicate.value) {
                              showToast('Duplicate Email Address!');
                              return;
                            } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailAddessCtrler.text)){
                              showToast('Invalid Email Address!');
                              return;
                            } else {
                              profileProvider.updateProfile({
                                "customerId": mainProvider.user.CustomerID,
                                "userId": mainProvider.user.UserID,
                                "gUID": mainProvider.user.GUID,
                                "password": passwordCtrler.text,
                                "userPhoneHome": homePhoneCtrler.text,
                                "userPhoneWork": workPhoneCtrler.text,
                                "userPhoneCell": mobilePhoneCtrler.text,
                                "userEmail": emailAddessCtrler.text,
                                "firstName": firstName,
                                "lastName": lastName,
                                'server': mainProvider.server,
                              }, context).then((_) {
                                profileProvider.getProfile({
                                  'customerId': mainProvider.user.CustomerID,
                                  'userId': mainProvider.user.UserID,
                                  'server': mainProvider.server
                                }, context);
                              });
                            }
                          } else {
                            showToast("Password don't match!");
                          }
                        },
                        isGradient: true),
                    const SizedBox(
                      height: 15,
                    ),
                    buttonContainer(
                        text: 'Cancel',
                        onPress: () => Navigator.of(context).pop(),
                        isGradient: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonContainer(
      {required String text,
      required Function() onPress,
      required bool isGradient}) {
    if (!isGradient) {
      return GestureDetector(
        onTap: onPress,
        child: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xffE1E1E1),
          child: Center(
            child: Text(text, style: const TextStyle(color: Colors.black)),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFFFC72E), Color(0xFFF87D1F)])),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  Widget textFieldWidget(
      String label,
      String hint,
      TextEditingController ctrler,
      bool isRequired,
      bool isNumberOnly,
      bool isEmail) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return TextFormField(
      onChanged: (value) async {
        if (isEmail) {
          await profileProvider.validateEmail({
            'emailAddress': emailAddessCtrler.text,
            'userId': mainProvider.user.UserID,
            'server': mainProvider.server,
          }, context);
          setState(() {});
        }
      },
      controller: ctrler,
      keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFC72E)),
          ),
          labelText: label,
          hintText: hint,
          errorText: errorMessage(isEmail: isEmail, profileProvider: profileProvider)),
    );
  }
  dynamic errorMessage({required bool isEmail, required ProfileProvider profileProvider}){
    if(isEmail && profileProvider.emailHasDuplicate.value){
      return 'Duplicate Email Address';
    } else if(isEmail && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailAddessCtrler.text)){
      return 'Invalid Email Address';
    }
    return null;
  }
}
