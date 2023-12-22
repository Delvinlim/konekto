import 'package:flutter/cupertino.dart';

void _showCancelReportDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Cancel Report?'),
      content: const Text('Are you sure want to cancel your report?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

class ReportSettingDetailPage extends StatefulWidget {
  const ReportSettingDetailPage({
    super.key,
    required this.reportNumber,
    required this.reportStatus,
    required this.reportDate,
  });
  final String reportNumber;
  final String reportStatus;
  final String reportDate;

  @override
  State<ReportSettingDetailPage> createState() => _ReportSettingDetailState();
}

class _ReportSettingDetailState extends State<ReportSettingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: const Text('Report Details'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context).pop(context),
            },
          ),
        ),
        child: SafeArea(
            child: Expanded(
          // padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFECEFF1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 52,
                      height: 52,
                      child: Icon(
                        CupertinoIcons.person,
                        color: CupertinoColors.black,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        widget.reportNumber,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 343,
                      child: Text(
                        widget.reportDate,
                        // 'October 20, 2023',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 69,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 4),
                      decoration: ShapeDecoration(
                        // color: const Color(0xFFEEEEEE),
                        color: widget.reportStatus == 'Waiting'
                            ? const Color(0xFFEEEEEE)
                            : widget.reportStatus == 'Approved'
                                ? const Color(0xFFCBFFC5)
                                : CupertinoColors.systemRed,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.reportStatus,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: widget.reportStatus == 'Waiting'
                                  ? CupertinoColors.black
                                  : widget.reportStatus == 'Approved'
                                      ? const Color(0xFF00B505)
                                      : CupertinoColors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'This report pertains to an incident involving the posting of sensitive and inappropriate content by a user on a digital platform. The individual in question has violated community guidelines and potentially engaged in behavior that could be harmful or offensive to others. This report aims to document the incident, provide relevant information, and request appropriate action from the platform administrators.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(vertical: 6),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      child: Text(
                        'Evidence',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/images/report_1.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/images/report_2.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/images/report_1.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _showCancelReportDialog(context);
                },
                child: Container(
                  // height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Cancel Report',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
