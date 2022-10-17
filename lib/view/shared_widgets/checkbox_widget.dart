import 'package:cp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import '../../provider/iot/home_provider.dart';
import '../../utils/utils/theme/global_colors.dart';

class CheckBoxWidget extends StatefulWidget {
  final String text;
  final leadingIcon;
  final bool status;
  final GestureTapCallback callback;
  final String itemId;
  final HomeProvider homeProvider;

  const CheckBoxWidget({
    Key? key,
    required this.text,
    this.leadingIcon,
    required this.status,
    required this.callback,
    required this.itemId,
    required this.homeProvider,
  }) : super(key: key);

  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final cpState = BehaviorSubject.seeded(true);
  @override
  Widget build(BuildContext context) {
    cpState.add(widget.status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      decoration: BoxDecoration(
        color: Provider.of<MainProvider>(context).darkTheme
            ? cpDarkContainerColor
            : cpGreyLightColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: StreamBuilder<bool>(
          stream: cpState,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const SizedBox();
            }
            final data = snapshot.data;
            return Row(
              children: [
                Checkbox(
                  value: data,
                  onChanged: (bool? value) {
                    if (widget.callback != null) {
                      final id = widget.itemId;
                      final isAdded = widget.homeProvider.selectedItems
                          .where((element) => element.containsValue(id));
                      if (isAdded.isNotEmpty) {
                        final idx = widget.homeProvider.selectedItems
                            .indexWhere(
                                (e) => e.values.elementAt(0) == widget.itemId);
                        widget.homeProvider.selectedItems.removeAt(idx);
                        widget.homeProvider.selectedItems.add({
                          'ItemID': widget.itemId,
                          'AddRemove': value! ? 'A' : 'R'
                        });
                      } else {
                        widget.homeProvider.selectedItems.add({
                          'ItemID': widget.itemId,
                          'AddRemove': value! ? 'A' : 'R'
                        });
                      }

                      widget.callback();
                      cpState.add(!data!);
                    }
                  },
                ),
                const SizedBox(width: 5),
                Text(widget.text.runtimeType.toString() == '_JsonMap' ||
                        widget.text.runtimeType.toString() ==
                            '_InternalLinkedHashMap<String, dynamic>'
                    ? 'Unknown Label'
                    : widget.text),
              ],
            );
          }),
    );
  }
}
