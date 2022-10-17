import 'package:cp/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../enum.dart';
import '../provider/iot/home_provider.dart';
import '../shared_widgets/shared_button.dart';
import '../shared_widgets/shared_text_field.dart';
import '../utils/utils/theme/global_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pwordCtrler = TextEditingController();
  final unameCtrler = TextEditingController();
  var rememberMeStatus = true;
  var isHidden = true;
  var idx = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      unameCtrler.text =
          await Provider.of<LoginProvider>(context, listen: false)
              .inputUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            color: cpGreyDarkColor,
            height: mqHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset('assets/images/login/mdu1.png'),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Customer Portal',
                        style: TextStyle(color: Colors.white)),
                    Text(versionNum,
                        style: const TextStyle(color: Colors.white))
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: StreamBuilder<ButtonState>(
                            stream: loginProvider.loginState$,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const SizedBox();
                              }
                              if (snapshot.data == ButtonState.loading) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }

                              return Column(
                                children: [
                                  dropDownServerWidget(),
                                  const SizedBox(height: 20),
                                  textFieldWidget(
                                      'Username', unameCtrler, false),
                                  passwordWidget('Password', pwordCtrler),
                                  textFieldSelection(
                                    'Remember Me?',
                                    rememberMeStatus,
                                    context,
                                  ),
                                  const SizedBox(height: 10),
                                  loginButtonWidget(loginProvider)
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownServerWidget() {
    return PopupMenuButton(
      // initialValue: 2,
      onSelected: (_) async {
        // await schedProv.removeLocalCredential();
        // Navigator.pushReplacementNamed(context, 'login');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(servers.elementAt(idx).values.elementAt(1),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
        ],
      ),
      itemBuilder: (context) {
        return List.generate(4, (index) {
          return PopupMenuItem(
            onTap: () => setState(() {
              idx = index;
            }),
            value: index,
            child: Text(
              servers.elementAt(index).values.elementAt(1),
            ),
          );
        });
      },
    );
  }

  Widget textFieldWidget(
      String title, TextEditingController ctrler, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        textFieldShared2(
          context,
          ctrler: ctrler,
          isFloatingLabel: false,
          labelText: title,
        ),
      ],
    );
  }

  Widget passwordWidget(String title, TextEditingController ctrler) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        textFieldShared2(
          context,
          ctrler: ctrler,
          isFloatingLabel: false,
          labelText: title,
          isObscureText: isHidden,
          suffixIcon: IconButton(
            icon: !isHidden
                ? const FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    color: Colors.grey,
                    size: 18,
                  )
                : const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget textFieldSelection(
    String title,
    bool status,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        initialValue: title,
        style: const TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        onTap: () async {
          setState(() {
            rememberMeStatus = !rememberMeStatus;
          });
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
                status ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.white),
            labelStyle: const TextStyle(
              color: Colors.black,
            )),
        readOnly: true,
      ),
    );
  }

  hidePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  loginButtonWidget(LoginProvider loginProvider) {
    return StretchableButton(
        text: 'Login',
        onPressed: () async {
          if (unameCtrler.text.isEmpty || pwordCtrler.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please fill up all fields",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
            return;
          }
          await loginProvider.onLogin({
            'username': unameCtrler.text,
            'password': loginProvider.generateMd5(pwordCtrler.text),
            'server': idx,
            'rememberMe': rememberMeStatus,
          }, context, () async {
            Navigator.pushReplacementNamed(context, 'main');
            await Provider.of<HomeProvider>(context, listen: false)
                .refreshHome(context);
          });
        });
  }
}
