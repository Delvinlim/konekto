import 'package:flutter/cupertino.dart';

class CommunitiesListPage extends StatelessWidget {
  const CommunitiesListPage({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CommunitiesList(
        categoryName: categoryName,
      ),
    );
  }
}

class CommunitiesList extends StatefulWidget {
  const CommunitiesList({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CommunitiesList> createState() => _CommunitiesListState();
}

class _CommunitiesListState extends State<CommunitiesList> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.categoryName),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(context),
          ),
        ),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.start, children: []));
  }
}
