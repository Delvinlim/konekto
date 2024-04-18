import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/models/communities_response.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/pages/communities/community_post_creation_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

class CommunityCreationModal extends StatelessWidget {
  const CommunityCreationModal({super.key, this.reverse = false});
  final bool reverse;
  static final GlobalKey<FormState> _formCommunityCreationKey =
      GlobalKey<FormState>();
  static String communityName = '';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      child: SafeArea(
          top: true,
          child: ListView(
            reverse: reverse,
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
                            const Text('Community Name'),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
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
                            const Text('Community Description'),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                placeholder: 'Community Description',
                                onChanged: (String? value) {
                                  if (value != null) {
                                    communityName = value;
                                    // setState(() {
                                    //   _selectedSegment = value;
                                    // });
                                  }
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
                            Navigator.pop(context);
                            Navigator.pop(context);
                            _showCommunityCreatedDialog(context, communityName);
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
    ));
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
    ));
  }
}
