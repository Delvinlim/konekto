import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

class ReportSettingsCard extends StatefulWidget {
  const ReportSettingsCard({super.key, required this.state});
  final String state;

  @override
  State<ReportSettingsCard> createState() => _ReportSettingsCardState();
}

class _ReportSettingsCardState extends State<ReportSettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 170,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(2, 6),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'October 20, 2023',
                    style: TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: ShapeDecoration(
                      color: widget.state == 'Waiting'
                          ? const Color(0xFFEEEEEE)
                          : widget.state == 'Approved'
                              ? const Color(0xFFCBFFC5)
                              : CupertinoColors.systemRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.state,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: widget.state == 'Waiting'
                                ? CupertinoColors.black
                                : widget.state == 'Approved'
                                    ? const Color(0xFF00B505)
                                    : CupertinoColors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    width: 52,
                    height: 52,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFECEFF1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 46,
                          height: 46,
                          child: Icon(
                            CupertinoIcons.person,
                            color: CupertinoColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    // width: 237,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 242.85,
                          child: Text(
                            '#RPKT52549233',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'Someone is sharing a sensitive content. there is a man in injured in a competition',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFF6F6F6),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Cancel Report',
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0689FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'View Details',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
