import 'package:flutter/widgets.dart';

import '../../constants.dart';
import '../../utils/utils/theme/global_colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cpGreyDarkColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: mqHeight(context) * .30,
            child: Image.asset('assets/images/login/mdu1.png',
                fit: BoxFit.scaleDown),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              // clipper: TriangleClipper(),
              child: Container(
                color: cpPrimaryColor,
                height: mqHeight(context) * .25,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                constraints: BoxConstraints(maxHeight: mqHeight(context) * .40),
                child: Image.asset(
                  'assets/images/home/person_icon.png',
                  fit: BoxFit.fitWidth,
                ),
              )),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
