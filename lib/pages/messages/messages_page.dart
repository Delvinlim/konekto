import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/message/message_widget.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Messages(),
    );
  }
}

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
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'ODBA',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Spartans',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'PSEG Fossil',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Devils Reject Nation',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'ODBA',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Spartans',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'PSEG Fossil',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Devils Reject Nation',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'ODBA',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Spartans',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'PSEG Fossil',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Devils Reject Nation',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'ODBA',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'Spartans',
                  ),
                  Message(
                    cameras: _cameras,
                    communityName: 'PSEG Fossil',
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
