import 'package:flutter/cupertino.dart';

class ExploreResult extends StatefulWidget {
  const ExploreResult({super.key});

  @override
  State<ExploreResult> createState() => _ExploreResultState();
}

class _ExploreResultState extends State<ExploreResult> {
  final FocusNode _searchFocusNode = FocusNode();
  var textController = TextEditingController(text: '');
  late List<Map> locationDatas;
  late List<Map> filteredDatas;

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
    textController = TextEditingController(text: '');
    locationDatas = [
      {
        'name': 'Devils Rejected Nation',
        'member': '105 Member',
        'status': 'Joined',
        'image': 'assets/images/communities/dnr.png',
      },
      {
        'name': 'Inter',
        'member': '105 Member',
        'status': 'Joined',
        'image': 'assets/images/communities/inter.png',
      },
      {
        'name': 'Spartans',
        'member': '105 Member',
        'status': 'Joined',
        'image': 'assets/images/communities/spartans.png',
      },
      {
        'name': 'Rasson',
        'member': '105 Member',
        'status': 'Joined',
        'image': 'assets/images/communities/rasson.png',
      },
      {
        'name': 'NorthArm',
        'member': '105 Member',
        'status': 'Joined',
        'image': 'assets/images/communities/northarm.png',
      },
    ];
    filteredDatas = locationDatas;
  }

  @override
  void dispose() {
    textController.dispose();
    _searchFocusNode.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void updateProductList(String value) {
      if (value.isNotEmpty) {
        filteredDatas = locationDatas
            .where((element) =>
                element['name'].toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        textController.text = '';
        filteredDatas = locationDatas;
      }

      setState(() {
        filteredDatas = filteredDatas;
      });
    }

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
              onChanged: (value) {
                updateProductList(value);
              },
              onSubmitted: (value) {
                updateProductList(value);
              },
              onSuffixTap: () {
                updateProductList('');
              },
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
          Expanded(
            child: ListView(
              children: [
                for (var index = 0; index < filteredDatas.length; index++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(
                              filteredDatas[index]['image'],
                              height: 35.0,
                              width: 35.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredDatas[index]['name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: CupertinoColors.black,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  filteredDatas[index]['member'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: CupertinoColors.black,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  filteredDatas[index]['status'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: CupertinoColors.black,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF0689FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Message',
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
