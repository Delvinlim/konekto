import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/modals/account_setting_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AccountSettingsItem extends StatefulWidget {
  const AccountSettingsItem(
      {super.key,
      required this.identifier,
      required this.name,
      required this.value});
  final String identifier;
  final String name;
  final String value;

  @override
  State<AccountSettingsItem> createState() => _AccountSettingsItemState();
}

class _AccountSettingsItemState extends State<AccountSettingsItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              builder: (context) => AccountSettingModal(
                    identifier: widget.identifier,
                    name: widget.name,
                    value: widget.value,
                  ));
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(
                        widget.value,
                        style: const TextStyle(
                            fontSize: 14, color: CupertinoColors.inactiveGray),
                      )),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: CupertinoColors.inactiveGray,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
