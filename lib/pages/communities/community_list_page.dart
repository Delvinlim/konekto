import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../widgets/card/communities_card_widget.dart';

class CommunitiesList extends StatefulWidget {
  const CommunitiesList(
      {super.key, required this.categoryName, required this.categoryId});
  final String categoryName;
  final String categoryId;

  @override
  State<CommunitiesList> createState() => _CommunitiesListState();
}

class _CommunitiesListState extends State<CommunitiesList> {
  late List<dynamic> communities = [{}];
  bool isCommunityFetched = false;

  @override
  void initState() {
    super.initState();
    fetchCommunityByCategory();
  }

  void fetchCommunityByCategory() async {
    setState(() {
      isCommunityFetched = true;
    });

    try {
      Response response = await dioClient.get(
        '/community/category/${widget.categoryId}',
      );
      if (response.statusCode == 200) {
        print('check my community response here....');
        // print(response);
        print(response.data['data'].runtimeType);
        print(response.data['data']);
        // Successful response, parse the JSON
        setState(() {
          isCommunityFetched = false;
          communities = response.data['data'];
        });
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch profile data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isCommunityFetched = false;
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
              'Please try again later',
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
    return CupertinoPageScaffold(
      // Uncomment to change the background color
      // backgroundColor: CupertinoColors.systemPink,
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.categoryName),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () => Navigator.of(context).pop(context),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Skeletonizer(
            enabled: isCommunityFetched,
            child: isCommunityFetched
                ? ListView(children: const [
                    CommunitiesCard(
                      communityId: '',
                      communityName: 'Aberdeen FC',
                      communityImage:
                          'assets/images/football_team/aberdeen.png',
                      communitySince: '2020',
                    ),
                    CommunitiesCard(
                      communityId: '',
                      communityName: 'Aberdeen FC',
                      communityImage:
                          'assets/images/football_team/aberdeen.png',
                      communitySince: '2020',
                    ),
                    CommunitiesCard(
                      communityId: '',
                      communityName: 'Aberdeen FC',
                      communityImage:
                          'assets/images/football_team/aberdeen.png',
                      communitySince: '2020',
                    ),
                    CommunitiesCard(
                      communityId: '',
                      communityName: 'Aberdeen FC',
                      communityImage:
                          'assets/images/football_team/aberdeen.png',
                      communitySince: '2020',
                    ),
                    CommunitiesCard(
                      communityId: '',
                      communityName: 'Aberdeen FC',
                      communityImage:
                          'assets/images/football_team/aberdeen.png',
                      communitySince: '2020',
                    ),
                    CommunitiesCard(
                      communityId: '',
                      communityName: 'Aberdeen FC',
                      communityImage:
                          'assets/images/football_team/aberdeen.png',
                      communitySince: '2020',
                    ),
                  ])
                : ListView(children: [
                    for (var community in communities)
                      CommunitiesCard(
                        communityId: community['id']?.toString() ?? '',
                        communityName: community['name'] ?? '',
                        communityImage: community['imageUrl'] ?? '',
                        communitySince: community['since']?.toString() ?? '',
                      ),
                  ]),
          )),
    );
  }
}
