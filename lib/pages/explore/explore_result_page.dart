import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:konekto/pages/auth/forget_password_page.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/widgets/card/event_card_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const ExploreResultPage());

class ExploreResultPage extends StatelessWidget {
  const ExploreResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ExploreResult(),
    );
  }
}

class ExploreResult extends StatefulWidget {
  const ExploreResult({super.key});

  @override
  State<ExploreResult> createState() => _ExploreResultState();
}

class _ExploreResultState extends State<ExploreResult> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        // Focus lost, navigate back to the previous page
        Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Remove focus from the previous page's input field immediately
          FocusManager.instance.primaryFocus?.unfocus();
        });
      }
    });
  }

  var textController = TextEditingController(text: '');

  @override
  void dispose() {
    textController.dispose();
    _searchFocusNode.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: CupertinoSearchTextField(
              controller: textController,
              placeholder: 'Search',
              focusNode: _searchFocusNode,
              autofocus: true,
              onTap: () {
                // Navigate to the blank page on search submit
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Container(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
