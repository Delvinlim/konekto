import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/message/message_widget.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<CameraDescription> _cameras = [];

  @override
  void initState() {
    super.initState();

    // final cameras = await availableCameras();
    // availableCameras().then((availableCameras) {
    //   cameras = availableCameras;
    //   camera = cameras.first;
    // });
    initCamera();
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();

    setState(() {
      _cameras = cameras;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Messages'),
        // ),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 40, left: 10, right: 10, bottom: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Message',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Column(
                children: [
                  Message(
                    cameras: _cameras,
                    communityName: 'Devils Reject Nation',
                    communityImage: 'assets/images/communities/dnr.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'ODBA',
                    communityImage: 'assets/images/communities/odba.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Spartans',
                    communityImage: 'assets/images/communities/spartans.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'PSEG Fossil',
                    communityImage: 'assets/images/communities/pseg_fossil.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Buaran',
                    communityImage: 'assets/images/communities/buaran.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Rasson',
                    communityImage: 'assets/images/communities/rasson.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Sydney Real',
                    communityImage: 'assets/images/communities/sydney_real.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'NorthArm',
                    communityImage: 'assets/images/communities/northarm.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Super Slasher Aquatics',
                    communityImage:
                        'assets/images/communities/super_slasher_aquatics.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Stryker Gaming',
                    communityImage:
                        'assets/images/communities/stryker_gaming.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Elite Basketball Club',
                    communityImage: 'assets/images/communities/elite.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Friends United',
                    communityImage:
                        'assets/images/communities/friends_united.png',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Hard Hitters',
                    communityImage: 'assets/images/communities/hardhitters.png',
                  ),
                ],
              ),
            ],
          ),
        ))
      ],
    ));
  }
}
