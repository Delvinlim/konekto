import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/communities_response.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

const _storage = FlutterSecureStorage();

class ExploreResult extends StatefulWidget {
  const ExploreResult({super.key});

  @override
  State<ExploreResult> createState() => _ExploreResultState();
}

class _ExploreResultState extends State<ExploreResult> {
  final FocusNode _searchFocusNode = FocusNode();
  var textController = TextEditingController(text: '');
  List<Map> locationDatas = [];
  List<Map> filteredDatas = [];
  bool isCommunitiesFetched = false;
  Map<String, List<KonektoCommunity>> communitiesByCategoriesList = {};

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        // Focus lost, navigate back to the previous page
        // Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Remove focus from the previous page's input field immediately
          FocusManager.instance.primaryFocus?.unfocus();
        });
      }
    });
    textController = TextEditingController(text: '');
    // locationDatas = [
    //   {
    //     'name': 'Devils Rejected Nation',
    //     'member': '105 Member',
    //     'status': 'Joined',
    //     'image': 'assets/images/communities/dnr.png',
    //   },
    //   {
    //     'name': 'Inter',
    //     'member': '105 Member',
    //     'status': 'Joined',
    //     'image': 'assets/images/communities/inter.png',
    //   },
    //   {
    //     'name': 'Spartans',
    //     'member': '105 Member',
    //     'status': 'Joined',
    //     'image': 'assets/images/communities/spartans.png',
    //   },
    //   {
    //     'name': 'Rasson',
    //     'member': '105 Member',
    //     'status': 'Joined',
    //     'image': 'assets/images/communities/rasson.png',
    //   },
    //   {
    //     'name': 'NorthArm',
    //     'member': '105 Member',
    //     'status': 'Joined',
    //     'image': 'assets/images/communities/northarm.png',
    //   },
    // ];
    // filteredDatas = locationDatas;
    _fetchCommunities();
  }

  @override
  void dispose() {
    textController.dispose();
    _searchFocusNode.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  void _fetchCommunities() async {
    setState(() {
      isCommunitiesFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get('/me/communities',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('communities list.....');
      print(response.data);
      // print(response.data['personalCommunities']);
      // print(response.data['joinedCommunities']);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunitiesResponse communitiesResponse =
            CommunitiesResponse.fromJson(responseData);

        print('check here important..');
        print(communitiesResponse);
        print(communitiesResponse.categories.values);
        // PersonalCommunitiesResponse personalCommunitiesResponse =
        //     PersonalCommunitiesResponse.fromJson(responseData);

        // JoinedCommunitiesResponse joinedCommunitiesResponse =
        //     JoinedCommunitiesResponse.fromJson(responseData);

        for (var communities in communitiesResponse.categories.values) {
          for (var community in communities) {
            print('here...');
            print(community);
            print('endhere...');
            locationDatas.add({
              'id': community.id,
              'name': community.name,
              'member': '105 Member',
              'status': 'Joined',
              'imageUrl': community.imageUrl,
              'since': community.since,
            });
          }
        }

        print('check here');
        print(locationDatas);

        setState(() {
          // personalCommunitiesList =
          //     personalCommunitiesResponse.communities ?? [];
          // joinedCommunitiesList = joinedCommunitiesResponse.communities ?? [];
          // communitiesByCategoriesList = communitiesResponse.categories;
          filteredDatas = locationDatas;
          isCommunitiesFetched = false;
        });
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch communities data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error getting community list...');
      print(e);
      setState(() {
        isCommunitiesFetched = false;
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
              'Failed to get posts',
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
    void updateProductList(String value) {
      if (value.isNotEmpty) {
        filteredDatas = locationDatas
            .where((element) =>
                element['name'].toLowerCase().contains(value.toLowerCase()) ??
                false)
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
              prefixIcon: const Icon(
                CupertinoIcons.back,
                color: CupertinoColors.black,
                size: 18,
              ),
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
                Navigator.pop(context);

                // Navigate to the blank page on search submit
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(
                //     builder: (context) => Container(),
                //   ),
                // );
              },
            ),
          ),
          Expanded(
            child: Skeletonizer(
              enabled: isCommunitiesFetched,
              child: isCommunitiesFetched
                  ? ListView(
                      children: [
                        for (var index = 0; index < 10; index++)
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
                                    child: Image.network(
                                      'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
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
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Community Name',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '2024',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // Text(
                                        //   filteredDatas[index]['status'],
                                        //   textAlign: TextAlign.center,
                                        //   style: const TextStyle(
                                        //     color: CupertinoColors.black,
                                        //     fontSize: 10,
                                        //     fontFamily: 'Inter',
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                    )
                  : ListView(
                      children: [
                        for (var index = 0;
                            index < filteredDatas.length;
                            index++)
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          CommunitiesDetailPage(
                                              communityId: filteredDatas[index]
                                                  ['id'],
                                              communityName:
                                                  filteredDatas[index]['name'],
                                              communityImage:
                                                  filteredDatas[index]
                                                      ['imageUrl']),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.network(
                                          (filteredDatas[index]['imageUrl'] !=
                                                      null &&
                                                  filteredDatas[index]
                                                          ['imageUrl'] !=
                                                      'null' &&
                                                  filteredDatas[index]
                                                          ['imageUrl']!
                                                      .isNotEmpty)
                                              ? filteredDatas[index]['imageUrl']
                                              : 'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              filteredDatas[index]['name'] ??
                                                  'Community Name',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: CupertinoColors.black,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              filteredDatas[index]['since'] ??
                                                  '2024',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: CupertinoColors.black,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            // Text(
                                            //   filteredDatas[index]['status'],
                                            //   textAlign: TextAlign.center,
                                            //   style: const TextStyle(
                                            //     color: CupertinoColors.black,
                                            //     fontSize: 10,
                                            //     fontFamily: 'Inter',
                                            //     fontWeight: FontWeight.w400,
                                            //   ),
                                            // ),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Detail',
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
                              )),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
