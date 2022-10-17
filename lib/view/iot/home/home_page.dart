import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants.dart';
import '../../../enum.dart';
import '../../../provider/iot/home_provider.dart';
import '../../../provider/main_provider.dart';
import '../../../shared_widgets/shared_widget.dart';
import '../../../utils/utils/image/svg_icon.dart';
import '../../../utils/utils/theme/global_colors.dart';
import 'home_widgets/rooms_widget.dart';
import 'home_widgets/scene_widget.dart';
import 'home_widgets/things_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  void _onRefresh() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .refreshHome(context);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final user = mainProvider.user;
    final iot = mainProvider.iot;

    return Scaffold(
        body: SmartRefresher(
      controller: _refreshController,
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: StreamBuilder<DataState>(
            stream: homeProvider.globallySelectedRoom$,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const SizedBox();
              }

              if (snapshot.data == DataState.loading) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: mqHeight(context),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      const SizedBox(height: 10),
                      Text(
                          'Setting Up ${homeProvider.globallySelectedRoom.RoomName} Devices'),
                    ],
                  )),
                );
              }

              return SizedBox(
                height: homeProvider.thingContainerHeight() < 1
                    ? 600
                    : 500 + homeProvider.thingContainerHeight(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 280,
                          color: cpGreyDarkColor,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 30, bottom: 30),
                                    child: Image.asset(
                                        'assets/images/login/mdu1.png',
                                        height: 30),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            highlightColor: Colors.white,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, 'schedule');
                                            },
                                            icon: svgIcon(
                                                'images/home/schedule_icon',
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          IconButton(
                                              highlightColor: Colors.white,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, 'pair');
                                              },
                                              icon: const Icon(
                                                Icons.speaker_phone_outlined,
                                                size: 28,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ))
                                ],
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                height: 100,
                                width: mqWidth(context),
                                child: StreamBuilder<DataState>(
                                    stream: homeProvider.scenes$,
                                    builder: (context, snapshot) {
                                      final data = homeProvider.scenes;
                                      if (snapshot.data == null ||
                                          snapshot.data == DataState.initial) {
                                        return const CircularProgressIndicator
                                            .adaptive();
                                      }
                                      return ListView.builder(
                                          itemCount: data.length + 1,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: ((context, index) {
                                            if (index == data.length) {
                                              return SceneWidget(
                                                svgIcon: 'Add More',
                                                title: 'Add More',
                                                iconColor: cpPrimaryColor,
                                                tap: () {
                                                  Navigator.pushNamed(context,
                                                      'scene_management');
                                                },
                                              );
                                            }
                                            final scene = data[index];

                                            return SceneWidget(
                                              svgIcon: scene.SceneName,
                                              title: scene.SceneName,
                                              iconColor: cpGreyLightColor,
                                              tap: () {
                                                for (var element
                                                    in scene.Items) {
                                                  homeProvider.setScene({
                                                    'hubUuid':
                                                        iot.ControllerUUID,
                                                    'bldgId': iot
                                                        .ControllerBuildingID,
                                                    'itemName':
                                                        element.ItemName,
                                                    'newValue':
                                                        element.ItemValue,
                                                    'customerId':
                                                        user.CustomerID,
                                                    'server':
                                                        mainProvider.server
                                                  }, context);
                                                }
                                              },
                                            );
                                          }));
                                    }),
                              ),
                              const SizedBox(height: 25),
                              const Divider(
                                color: Colors.grey,
                                height: 5,
                                endIndent: 15,
                                indent: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox()
                      ],
                    ),
                    Positioned(
                        height: homeProvider.thingContainerHeight() + 500,
                        top: 170,
                        left: 5,
                        right: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      homeProvider
                                          .globallySelectedRoom.RoomName,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  const Icon(Icons.bookmark,
                                      color: Colors.white)
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 600),
                                  child: StreamBuilder<DataState>(
                                      stream: homeProvider.currentRoom$,
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null) {
                                          return const SizedBox();
                                        }
                                        if (snapshot.data ==
                                            DataState.initial) {
                                          return const SizedBox();
                                        }

                                        if (snapshot.data ==
                                            DataState.loading) {
                                          return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive());
                                        }
                                        return ThingsContainer(
                                          homeProvider: homeProvider,
                                        );
                                      }),
                                ),
                                const RoomsWidget()
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
