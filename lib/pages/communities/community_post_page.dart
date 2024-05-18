import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/community_posts_response.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/message/comment_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../widgets/card/communities_card_widget.dart';

const _storage = FlutterSecureStorage();

class CommunitiesPost extends StatefulWidget {
  const CommunitiesPost(
      {super.key,
      required this.postId,
      required this.communityName,
      required this.communityId});
  final String postId;
  final String communityName;
  final String communityId;

  @override
  State<CommunitiesPost> createState() => _CommunitiesPostState();
}

class _CommunitiesPostState extends State<CommunitiesPost> {
  var textController = TextEditingController(text: '');
  bool isPostsFetched = false;
  PostResponse postsList = PostResponse(
      communityPosts: CommunityPost(
          id: '',
          communityId: '',
          content: '',
          date: '',
          imageUrl: '',
          partnerId: '',
          communityDetail: null,
          partnerDetail: null));

  final List<Map> commentsMessage = [
    {'message': 'Semangat Bang'},
    {'message': 'Nice Banget Bang'},
  ];
  final List<Widget> comments = [
    const Comment(
      message: 'Semangat Bang',
    ),
    const Comment(
      message: 'Nice Banget Bang',
    ),
  ];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() async {
    setState(() {
      isPostsFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      print('before executing...');
      print(widget.postId);
      Response response = await dioClient.get(
          '/community/post/${widget.postId}',
          data: {},
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here..');
      print(response);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        print('here.');
        print(responseData);
        PostResponse communityPostsResponse =
            PostResponse.fromJson(responseData);
        setState(() {
          postsList = communityPostsResponse;
          isPostsFetched = false;
        });
        // Successful response, parse the JSON
        print('posts...');
        print(communityPostsResponse.communityPosts?.partnerDetail);
        // print(communityPostsResponse.partnerDetail);
        print('end post response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error post hereeeee...');
      print(e);
      setState(() {
        isPostsFetched = false;
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
              'Failed to get communities',
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.communityName),
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(context),
        ),
      ),
      child: Column(
        children: [
          Skeletonizer(
            enabled: isPostsFetched,
            child: isPostsFetched
                ? const ForYouCommunitiesCard(
                    communityId: '1',
                    communityName: 'DTS System',
                    communityImage:
                        'assets/images/communities/odba.png', // TODO Image Url
                    content:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    contentImage:
                        'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713103435/Konekto/posts/sdkns2vialkwkcbizgpw.png',
                    creatorName: 'Delvin Lim',
                    postId: '1',
                    isRedirect: true,
                  )
                : ForYouCommunitiesCard(
                    communityId: widget.communityId,
                    communityName: widget.communityName,
                    postId: widget.postId,
                    communityImage: 'assets/images/communities/odba.png',
                    creatorName: postsList.communityPosts?.partnerDetail?.name,
                    content: postsList.communityPosts?.content,
                    contentImage: postsList.communityPosts?.imageUrl,
                    isRedirect: false,
                  ),
          ),
          const Divider(
            height: 4,
            color: CupertinoColors.black,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,

                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0; index < commentsMessage.length; index++)
                      Comment(
                        message: commentsMessage[index]['message'],
                      )
                  ],
                ),
              ),
            ),
          )),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.white,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 20), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    // onTap: () => Navigator.of(context, rootNavigator: true)
                    //     .push(CupertinoPageRoute(
                    //         builder: (context) => CameraScreen(
                    //               cameras: widget.cameras,
                    //             ))),
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: CupertinoColors.black,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CupertinoTextField(
                      controller: textController,
                      placeholder: 'Message',
                      onChanged: (value) => setState(() {
                        textController.text = value;
                      }),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        commentsMessage.add({'message': textController.text});
                      });
                      textController.text = '';
                    },
                    child: const Icon(
                      CupertinoIcons.paperplane,
                      color: CupertinoColors.black,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
