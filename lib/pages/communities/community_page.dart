import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const CommunitiesPage());

enum CommunitiesType { forYou, yourCommunities, discover }

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Communities(),
    );
  }
}

class Communities extends StatefulWidget {
  const Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  CommunitiesType _selectedSegment = CommunitiesType.forYou;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Communities'),
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
                            'Communities',
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
        Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            width: double.infinity,
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * 0.10,
              child: CupertinoSlidingSegmentedControl<CommunitiesType>(
                backgroundColor: CupertinoColors.systemGrey2,
                thumbColor: Colors.blue.shade600,
                // This represents the currently selected segmented control.
                groupValue: _selectedSegment,
                // Callback that sets the selected segmented control.
                onValueChanged: (CommunitiesType? value) {
                  if (value != null) {
                    setState(() {
                      _selectedSegment = value;
                    });
                  }
                },
                children: const <CommunitiesType, Widget>{
                  CommunitiesType.forYou: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'All',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                  CommunitiesType.yourCommunities: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'System',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                  CommunitiesType.discover: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Community',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                },
              ),
            )),
      ],
    ));
  }
}
