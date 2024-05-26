import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/profile_response.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/appbar/app_bar_widget.dart';
import 'package:konekto/widgets/camera/camera_widget.dart';
import 'package:konekto/widgets/message/comment_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

const _storage = FlutterSecureStorage();

class CommunitiesPostCreationPage extends StatefulWidget {
  const CommunitiesPostCreationPage(
      {super.key, required this.communityName, required this.communityId});
  final String communityName;
  final String communityId;

  @override
  State<CommunitiesPostCreationPage> createState() =>
      _CommunitiesPostCreationState();
}

class _CommunitiesPostCreationState extends State<CommunitiesPostCreationPage> {
  ProfileResponse userProfile =
      ProfileResponse(id: '', name: '', username: '', email: '');
  List<CameraDescription> _cameras = [];
  var contentController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    initCamera();
  }

  void _fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userPref = prefs.getString('user');
    print('profile user..');
    print(userPref);
    ProfileResponse profileResponse =
        ProfileResponse.fromJson(json.decode(userPref!));

    setState(() {
      userProfile = profileResponse;
    });
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();

    setState(() {
      _cameras = cameras;
    });
  }

  void _createPost() async {
    print('check here content controller');
    print(contentController.text);
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.post('/community/post',
          data: {
            'communityId': widget.communityId,
            'content': contentController.text,
            'imageUrl': ''
          },
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here..');
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful response, parse the JSON
        print('end post response');
        // Show Notification
        // ignore: use_build_context_synchronously
        toastification.show(
          // ignore: use_build_context_synchronously
          context: context,
          title: const Text("Success"),
          description: Text(
            response.data['message'] ?? 'Successfully created!',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          autoCloseDuration: const Duration(seconds: 2),
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          alignment: Alignment.topCenter,
          direction: TextDirection.ltr,
          dragToClose: false,
          showProgressBar: false,
          closeButtonShowType: CloseButtonShowType.none,
          callbacks: ToastificationCallbacks(
              onAutoCompleteCompleted: (toastItem) => {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const KonektoTabBar()),
                        ((route) => false))
                  }),
        );
        EasyLoading.dismiss();
      } else {
        // Handle error response (non-200 status code)
        print('Failed to create post: ${response.statusCode}');
        EasyLoading.dismiss();
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();

      print('error post disini.......');
      print(e);
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: Text(e.response?.data['message']),
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.warning,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: e.message != null
                ? Text(e.response!.statusMessage!)
                : const Text("Server Error"),
            description: const Text(
              'Failed to create post',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.communityName),
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(context),
        ),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Comment(
                  //   message: 'Semangat Bang',
                  // ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(
                              'assets/images/profile.png',
                              height: 35.0,
                              width: 35.0,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfile.name ?? 'Default User',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .push(CupertinoPageRoute(
                            builder: (context) => CameraScreen(
                                  cameras: _cameras,
                                ))),
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: CupertinoColors.black,
                    ),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(bottom: 16),
            child: CupertinoTextField(
              controller: contentController,
              maxLines: 8,
              placeholder: 'Write something',
              onChanged: (value) => setState(() {
                contentController.text = value;
              }),
            ),
          ),
          CupertinoButton(
              color: Colors.blue.shade600,
              child: const Text('Post',
                  style: TextStyle(
                      fontSize: 16,
                      // color: CupertinoColors.black,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                EasyLoading.show(
                    status: 'loading...', maskType: EasyLoadingMaskType.black);
                FocusManager.instance.primaryFocus?.unfocus();
                _createPost();
              }),
        ],
      ),
    );
  }
}
