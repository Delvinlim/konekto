import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/message/message_widget.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

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
        StreamBuilder<List<types.Room>>(
            stream: FirebaseChatCore.instance.rooms(),
            initialData: const [],
            builder: (context, snapshot) {
              print('check snapshot');
              print(snapshot);
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    bottom: 200,
                  ),
                  child: const Text('No messages'),
                );
              }
              // return ListView.builder(
              //     itemCount: snapshot.data!.length,
              //     itemBuilder: (context, index) {
              //       final room = snapshot.data![index];
              //       Message(
              //         cameras: _cameras,
              //         communityName: 'Devils Reject Nation',
              //         communityImage: 'assets/images/communities/dnr.png',
              //       );
              //     });

              return Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Column(
                      children: [
                        for (var index = 0;
                            index < snapshot.data!.length;
                            index++)
                          Message(
                            cameras: _cameras,
                            communityName:
                                snapshot.data![index].name.toString(),
                            communityRoom: snapshot.data![index],
                            communityImage: 'assets/images/communities/dnr.png',
                          ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'ODBA',
                        //   communityImage: 'assets/images/communities/odba.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Spartans',
                        //   communityImage:
                        //       'assets/images/communities/spartans.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'PSEG Fossil',
                        //   communityImage:
                        //       'assets/images/communities/pseg_fossil.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Buaran',
                        //   communityImage:
                        //       'assets/images/communities/buaran.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Rasson',
                        //   communityImage:
                        //       'assets/images/communities/rasson.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Sydney Real',
                        //   communityImage:
                        //       'assets/images/communities/sydney_real.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'NorthArm',
                        //   communityImage:
                        //       'assets/images/communities/northarm.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Super Slasher Aquatics',
                        //   communityImage:
                        //       'assets/images/communities/super_slasher_aquatics.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Stryker Gaming',
                        //   communityImage:
                        //       'assets/images/communities/stryker_gaming.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Elite Basketball Club',
                        //   communityImage: 'assets/images/communities/elite.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Friends United',
                        //   communityImage:
                        //       'assets/images/communities/friends_united.png',
                        // ),
                        // Message(
                        //   cameras: _cameras,
                        //   communityName: 'Hard Hitters',
                        //   communityImage:
                        //       'assets/images/communities/hardhitters.png',
                        // ),
                      ],
                    ),
                  ],
                ),
              ));
            }),
      ],
    ));
  }
}
