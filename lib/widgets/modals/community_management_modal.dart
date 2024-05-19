import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/communities_response.dart';
import 'package:konekto/models/community_categories_response.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/pages/communities/community_post_creation_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class CommunityManagementModal extends StatelessWidget {
  const CommunityManagementModal(
      {super.key,
      this.reverse = false,
      required this.personalCommunities,
      required this.joinedCommunities});
  final bool reverse;
  final List<KonektoCommunity> personalCommunities;
  final List<KonektoCommunity> joinedCommunities;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      child: SafeArea(
          top: false,
          child: ListView(
            reverse: reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Create Community',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.people),
                onTap: () => showCupertinoModalBottomSheet(
                    expand: false,
                    context: context,
                    builder: ((context) => CommunityCreationModal(
                          reverse: reverse,
                        ))),
              ),
              ListTile(
                title: const Text(
                  'Create Post',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.post_add),
                onTap: () => showCupertinoModalBottomSheet(
                    expand: false,
                    context: context,
                    builder: ((context) => CommunityListModal(
                          reverse: reverse,
                          personalCommunities: personalCommunities,
                          joinedCommunities: joinedCommunities,
                        ))),
              ),
            ],
          )),
    ));
  }
}

void _showCommunityCreatedDialog(BuildContext context, String communityName) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Success'),
      content: const Text('Your community successfully created'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                builder: (context) => CommunitiesDetailPage(
                      communityId: '', //TODO use correct id
                      communityName: communityName,
                      communityImage: 'assets/images/communities/odba.png',
                    )));
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

const double _kItemExtent = 50.0;
const _storage = FlutterSecureStorage();

class CommunityCreationModal extends StatefulWidget {
  const CommunityCreationModal({super.key, this.reverse = false});
  final bool reverse;

  @override
  State<CommunityCreationModal> createState() => _CommunitiesCreationState();
}

// class CommunityCreationModal extends StatelessWidget {
class _CommunitiesCreationState extends State<CommunityCreationModal> {
  static final GlobalKey<FormState> _formCommunityCreationKey =
      GlobalKey<FormState>();
  static String communityName = '';
  int selectedCategories = 0;
  var nameController = TextEditingController(text: '');
  var categoryController = TextEditingController(text: '');
  var categoryIdController = TextEditingController(text: '');
  var sinceController = TextEditingController(text: '');
  var locationController = TextEditingController(text: '');
  var descriptionController = TextEditingController(text: '');

  bool isCategoriesFetched = false;
  List<CommunityCategory> communityCategoriesList = [];

  @override
  void initState() {
    super.initState();
    _fetchCommunityCategories();
  }

  void _fetchCommunityCategories() async {
    setState(() {
      isCategoriesFetched = true;
    });

    try {
      Response response = await dioClient.get('/community/categories');
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunityCategoriesResponse communityCategoriesResponse =
            CommunityCategoriesResponse.fromJson(responseData);
        print('community categories response');
        print(responseData);
        setState(() {
          communityCategoriesList =
              communityCategoriesResponse.categories ?? [];
          isCategoriesFetched = false;
        });
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isCategoriesFetched = false;
      });
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
              'Please try again later',
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

  void _createCommunity() async {
    try {
      dynamic accessToken = await _storage.read(key: 'jwtToken');
      // await FirebaseChatCore.instance.room(roomId)
      print('hello');
      List<types.User> userUids = List.empty(growable: true);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          print(user.uid);
          userUids.add(types.User(id: user.uid));
          // final room = await FirebaseChatCore.instance.createGroupRoom(name: name, users: users)
        }
      });
      final room = await FirebaseChatCore.instance
          .createGroupRoom(name: nameController.text, users: userUids);
      // Consume API
      Response res = await dioClient
          .post('/community',
              data: {
                'communityName': nameController.text,
                'description': descriptionController.text,
                'categoryId': categoryIdController.text,
                'privacy': 'public',
                'location': locationController.text,
                'since': sinceController.text,
                'roomId': room.id
              },
              options:
                  Options(headers: {"Authorization": 'Bearer $accessToken'}))
          .timeout(const Duration(seconds: 30));
      final response = json.decode(res.toString());
      print('check response..');
      print(response);
      print('end response..');

      EasyLoading.dismiss();

      // Show Notification
      // ignore: use_build_context_synchronously
      toastification.show(
        context: context,
        title: const Text("Success"),
        description: const Text(
          'Please wait a moment...',
          style: TextStyle(fontWeight: FontWeight.w500),
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
                  Navigator.pop(context),
                  Navigator.pop(context),
                  // _showCommunityCreatedDialog(context, communityName),
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                          builder: (context) => CommunitiesDetailPage(
                                communityId: response['community']['id']
                                    .toString(), //TODO use correct id
                                communityName: response['community']['name'],
                                communityImage:
                                    'assets/images/communities/odba.png',
                              )))
                }),
      );
    } on DioException catch (e) {
      // cancelToken.cancel();
      EasyLoading.dismiss();
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response?.statusCode != 429) {
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
        // print(e.requestOptions);
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: e.message != null
                ? Text(e.response!.statusMessage!)
                : const Text("Server Error"),
            description: const Text(
              'Please try again later',
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
    // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
    // ignore: no_leading_underscores_for_local_identifiers
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
    }

    return CupertinoPageScaffold(
      child: SafeArea(
          top: true,
          child: ListView(
            reverse: widget.reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            children: [
              const Text(
                'Create Community',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: Form(
                    key: _formCommunityCreationKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Community Name',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                keyboardType: TextInputType.name,
                                controller: nameController,
                                onChanged: (value) {
                                  setState(() {
                                    nameController.text = value;
                                  });
                                },
                                placeholder: 'Community Name',
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey.shade400),
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter community name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Community Category',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                keyboardType: TextInputType.none,
                                placeholder: 'Community Category',
                                controller: categoryController,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                onTap: () => _showDialog(
                                  CupertinoPicker(
                                    magnification: 1.25,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: _kItemExtent,
                                    // This sets the initial item.
                                    scrollController:
                                        FixedExtentScrollController(
                                      initialItem: selectedCategories,
                                    ),
                                    // This is called when selected item is changed.
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        selectedCategories = selectedItem;
                                        categoryController.text =
                                            communityCategoriesList[
                                                    selectedItem]
                                                .name!;
                                        categoryIdController.text =
                                            communityCategoriesList[
                                                    selectedItem]
                                                .id!;
                                      });
                                    },
                                    children: List<Widget>.generate(
                                        communityCategoriesList.length,
                                        (int index) {
                                      return Center(
                                          child: Text(
                                              communityCategoriesList[index]
                                                  .name!));
                                    }),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey.shade400),
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter community creation date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Community Since',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                keyboardType: TextInputType.number,
                                placeholder: 'Community Since',
                                controller: sinceController,
                                onChanged: (value) {
                                  setState(() {
                                    sinceController.text = value;
                                  });
                                },
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey.shade400),
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter community creation date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Community Location',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                keyboardType: TextInputType.streetAddress,
                                placeholder: 'Community Location',
                                controller: locationController,
                                onChanged: (value) {
                                  setState(() {
                                    locationController.text = value;
                                  });
                                },
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey.shade400),
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter community location';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Community Description',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                placeholder: 'Community Description',
                                controller: descriptionController,
                                onChanged: (value) {
                                  setState(() {
                                    descriptionController.text = value;
                                  });
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey.shade400),
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter community description';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),

              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: const Text('Cancel',
                            style: TextStyle(
                                fontSize: 14,
                                // color: CupertinoColors.black,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CupertinoButton(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        color: Colors.blue.shade600,
                        child: const Text('Create',
                            style: TextStyle(
                                fontSize: 14,
                                // color: CupertinoColors.black,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (_formCommunityCreationKey.currentState!
                              .validate()) {
                            EasyLoading.show(
                                status: 'loading...',
                                maskType: EasyLoadingMaskType.black);
                            _createCommunity();
                          }
                        }),
                  )
                ],
              )

              // ListTile(
              //   title: const Text(
              //     'ODBA',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   subtitle: const Text('Last updated 1 hour ago'),
              //   leading: const Icon(Icons.people),
              //   onTap: () => Navigator.of(context, rootNavigator: true).push(
              //       CupertinoPageRoute(
              //           builder: (context) => const SettingsPage())),
              // ),
            ],
          )),
    );
  }
}

class CommunityListModal extends StatelessWidget {
  const CommunityListModal(
      {super.key,
      this.reverse = false,
      required this.personalCommunities,
      required this.joinedCommunities});
  final bool reverse;
  final List<KonektoCommunity> personalCommunities;
  final List<KonektoCommunity> joinedCommunities;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
          top: false,
          child: ListView(
            reverse: reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              for (var community in personalCommunities + joinedCommunities)
                ListTile(
                  title: Text(
                    community.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Last updated 1 hour ago'),
                  leading: Image.asset('assets/images/communities/odba.png'),
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                          builder: (context) => CommunitiesPostCreationPage(
                                communityName: community.name!,
                              ))),
                ),
            ],
          )),
    );
  }
}
