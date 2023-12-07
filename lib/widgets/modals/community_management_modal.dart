import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/settings/settings_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommunityManagementModal extends StatelessWidget {
  const CommunityManagementModal({super.key, this.reverse = false});
  final bool reverse;

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
                onTap: () => Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (context) => const SettingsPage())),
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
                        ))),
              ),
            ],
          )),
    ));
  }
}

class CommunityListModal extends StatelessWidget {
  const CommunityListModal({super.key, this.reverse = false});
  final bool reverse;

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
                  'ODBA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Last updated 1 hour ago'),
                leading: const Icon(Icons.people),
                onTap: () => Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (context) => const SettingsPage())),
              ),
              ListTile(
                title: const Text(
                  'Buaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Last updated 1 hour ago'),
                leading: const Icon(Icons.post_add),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: const Text(
                  'ODBA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Last updated 1 hour ago'),
                leading: const Icon(Icons.people),
                onTap: () => Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (context) => const SettingsPage())),
              ),
              ListTile(
                title: const Text(
                  'Buaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Last updated 1 hour ago'),
                leading: const Icon(Icons.post_add),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: const Text(
                  'ODBA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Last updated 1 hour ago'),
                leading: const Icon(Icons.people),
                onTap: () => Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (context) => const SettingsPage())),
              ),
              ListTile(
                title: const Text(
                  'Buaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Last updated 1 hour ago'),
                leading: const Icon(Icons.post_add),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          )),
    ));
  }
}
