import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  AnimationController? animateController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginProv = Provider.of<LoginProvider>(context, listen: false);
      final result = await loginProv.getLocalCredential();
      if (result != null) {
        Navigator.pushReplacementNamed(context, 'main');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox());
  }
}
