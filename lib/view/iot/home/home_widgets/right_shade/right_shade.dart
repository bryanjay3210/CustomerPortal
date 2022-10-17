import 'package:cp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/iot/home_provider.dart';
import '../../../../../utils/utils/theme/global_colors.dart';
import 'custom_slider.dart';

class RightShade extends StatefulWidget {
  final int index;
  const RightShade({Key? key, required this.index}) : super(key: key);

  @override
  _RightShadeState createState() => _RightShadeState();
}

class _RightShadeState extends State<RightShade> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final humanName =
        homeProvider.currentRoom[widget.index].values.first[0].ThingHumanName;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: mainProvider.darkTheme ? cpDarkContainerColor : cpGreyLightColor,
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              humanName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: mainProvider.darkTheme ? cpWhiteColor : cpGreyDarkColor,
              ),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: cpDivOnLightColor,
          ),
          CustomSlider(index: widget.index),
        ],
      ),
    );
  }
}
