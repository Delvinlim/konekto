import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/pages/communities/community_post_page.dart';
import 'package:konekto/pages/communities/community_rules_page.dart';
import 'package:konekto/pages/communities/community_settings_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

const _storage = FlutterSecureStorage();

class CommunitiesCard extends StatelessWidget {
  const CommunitiesCard({
    super.key,
    required this.communityId,
    required this.communityName,
    required this.communityImage,
    required this.communitySince,
    this.isJoined,
  });
  final String? communityId;
  final String? communityName;
  final String? communityImage;
  final String? communitySince;
  final bool? isJoined;

  // @override
  // State<CommunitiesCard> createState() => _CommunitiesCardState();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CommunitiesDetailPage(
                        communityId: communityId!,
                        communityName: communityName!,
                        communityImage: communityImage!,
                        isJoined: isJoined ?? false,
                      )));
        },
        child: Row(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 52,
                    height: 52,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFECEFF1),
                            shape: OvalBorder(),
                          ),
                        ),
                        Container(
                          width: 46,
                          height: 46,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: () {
                                if (communityImage != null &&
                                    communityImage != 'null' &&
                                    communityImage!.isNotEmpty) {
                                  print(
                                      'Using community image: $communityImage');
                                  print(
                                      'communityImage type: ${communityImage.runtimeType}');
                                  print(communityImage != null);
                                  print(communityImage!.isNotEmpty);
                                  return NetworkImage(communityImage!);
                                } else {
                                  const fallbackImageUrl =
                                      'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png';
                                  print(
                                      'Using fallback image: $fallbackImageUrl');
                                  return const NetworkImage(fallbackImageUrl);
                                }
                              }(),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(232),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          communityName!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Since $communitySince',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// class _CommunitiesCardState extends State<CommunitiesCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 130,
//           height: 60,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 52,
//                 height: 52,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 0,
//                       top: 0,
//                       child: Container(
//                         width: 52,
//                         height: 52,
//                         decoration: const ShapeDecoration(
//                           color: Color(0xFFECEFF1),
//                           shape: OvalBorder(),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       child: SizedBox(
//                         width: 46,
//                         height: 46,
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               child: Container(
//                                 width: 46,
//                                 height: 46,
//                                 decoration: ShapeDecoration(
//                                   image: const DecorationImage(
//                                     image: NetworkImage(
//                                         "https://via.placeholder.com/46x46"),
//                                     fit: BoxFit.fill,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(232),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Container(
//                 clipBehavior: Clip.antiAlias,
//                 decoration: const BoxDecoration(),
//                 child: const Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'ODBA',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: CupertinoColors.black,
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       'Since 2019',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: CupertinoColors.black,
//                         fontSize: 12,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class ForYouCommunitiesCard extends StatefulWidget {
  const ForYouCommunitiesCard(
      {super.key,
      required this.communityId,
      required this.communityName,
      required this.communityImage,
      required this.creatorName,
      required this.content,
      required this.contentImage,
      required this.postId,
      this.isRedirect});
  final String? communityId;
  final String? communityName;
  final String? communityImage;
  final String? creatorName;
  final String? content;
  final String? contentImage;
  final String? postId;
  final bool? isRedirect;

  @override
  State<ForYouCommunitiesCard> createState() => _ForYouCommunitiesCardState();
}

class _ForYouCommunitiesCardState extends State<ForYouCommunitiesCard> {
  IconData heartIcon = CupertinoIcons.heart;
  bool likedByUser = false;
  num totalLikes = 0;
  num totalComments = 0;

  @override
  void initState() {
    super.initState();
    fetchPostMetadata();
    checkUserLiked();
  }

  void fetchPostMetadata() async {
    try {
      Response res = await dioClient.get('/post/${widget.postId}/metadata');
      final response = json.decode(res.toString());
      if (res.statusCode == 200) {
        // Successful response, parse the JSON
        // Map<String, dynamic> responseData = response.data;
        // CommunityPostsResponse communityPostsResponse =
        //     CommunityPostsResponse.fromJson(responseData);
        setState(() {
          totalLikes = response['data']['totalLikes']['count'] ?? 0;
          totalComments = response['data']['totalComments']['count'] ?? 0;
          // postsList = communityPostsResponse.communityPosts ?? [];
          // isPostsFetched = false;
        });
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch post metadata data: ${res.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error post metadata...');
      print(e);
      // setState(() {
      //   isPostsFetched = false;
      // });
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
              'Failed to get post metadata',
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

  void likePost() async {
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response res = await dioClient.post('/community/post/likes',
          data: {
            'postId': widget.postId,
          },
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      final response = json.decode(res.toString());
      print('check like post');
      print(response);
      if (res.statusCode == 201) {
        // Successful response, parse the JSON
        setState(() {
          // totalLikes = response['data']['totalLikes']['count'] ?? 0;
          // totalComments = response['data']['totalComments']['count'] ?? 0;
          // postsList = communityPostsResponse.communityPosts ?? [];
          // isPostsFetched = false;
        });
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to like post: ${res.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error like post...');
      print(e);
      // setState(() {
      //   isPostsFetched = false;
      // });
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
              'Failed to like post',
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

  void checkUserLiked() async {
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response res = await dioClient.get(
          '/community/post/${widget.postId}/is-liked',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      final response = json.decode(res.toString());
      print('check is liked user');
      print(response);
      if (res.statusCode == 201) {
        // Successful response, parse the JSON
        setState(() {
          likedByUser = response['isLiked'] ?? false;
          heartIcon = response['isLiked']
              ? CupertinoIcons.heart_fill
              : CupertinoIcons.heart;
        });
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to check if user liked post: ${res.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error check user liked post...');
      print(e);
      // setState(() {
      //   isPostsFetched = false;
      // });
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
              'Failed to like post',
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
    return GestureDetector(
      onTap: () {
        if (widget.isRedirect == true) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CommunitiesPost(
                        communityName: widget.communityName ?? 'Default Name',
                        communityImage: widget.communityImage ??
                            'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
                        communityId: widget.communityId ?? '1',
                        postId: widget.postId ?? '1',
                      )));
        }
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          widget.communityImage ??
                              'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.communityName ?? 'Default Community',
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.creatorName ?? 'Admin',
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Text(
                  'October, 3 2023',
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            if (widget.contentImage != null && widget.contentImage != '')
              // Container(
              //   height: 300,
              //   decoration: ShapeDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(widget.contentImage!),
              //       fit: BoxFit.fill,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 250,
                child: AspectRatio(
                  aspectRatio: 1.0, // Set aspect ratio to 1:1 (square)
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.contentImage!,
                      fit: BoxFit.cover, // Use BoxFit.cover to fill the square
                      loadingBuilder: (context, widget, loadingProgress) {
                        if (loadingProgress == null) {
                          return widget;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                            color: CupertinoColors.black,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (widget.contentImage != null && widget.contentImage != '')
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likePost();
                                  setState(() {
                                    heartIcon == CupertinoIcons.heart_fill
                                        ? {
                                            heartIcon = CupertinoIcons.heart,
                                            totalLikes -= 1
                                          }
                                        : {
                                            heartIcon =
                                                CupertinoIcons.heart_fill,
                                            totalLikes += 1
                                          };
                                  });
                                },
                                child: Icon(
                                  heartIcon,
                                  color: heartIcon == CupertinoIcons.heart_fill
                                      ? CupertinoColors.systemRed
                                      : CupertinoColors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                totalLikes.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              )
                            ]),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.chat_bubble_text,
                                  color: CupertinoColors.black,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  totalComments.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )
                              ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('tapped');
                            Share.share('''Hey! check it out\n'''
                                '''Post In: ${widget.communityName}, By: ${widget.creatorName}\n'''
                                '''Says that: ${widget.content}\n''');
                          },
                          child: const Icon(
                            CupertinoIcons.paperplane,
                            color: CupertinoColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.content!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.contentImage == null || widget.contentImage == '')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.content!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likePost();
                                  setState(() {
                                    heartIcon == CupertinoIcons.heart_fill
                                        ? {
                                            heartIcon = CupertinoIcons.heart,
                                            totalLikes -= 1
                                          }
                                        : {
                                            heartIcon =
                                                CupertinoIcons.heart_fill,
                                            totalLikes += 1
                                          };
                                  });
                                },
                                child: Icon(
                                  heartIcon,
                                  color: heartIcon == CupertinoIcons.heart_fill
                                      ? CupertinoColors.systemRed
                                      : CupertinoColors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                totalLikes.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              )
                            ]),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.chat_bubble_text,
                                  color: CupertinoColors.black,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  totalComments.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )
                              ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('tapped');
                            Share.share('''Hey! check it out\n'''
                                '''Post In: ${widget.communityName}, By: ${widget.creatorName}\n'''
                                '''Says that: ${widget.content}\n''');
                          },
                          child: const Icon(
                            CupertinoIcons.paperplane,
                            color: CupertinoColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class CommunitySettingModal extends StatelessWidget {
  const CommunitySettingModal(
      {super.key, this.reverse = false, this.isJoined = false});
  final bool reverse;
  final bool? isJoined;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      child: SafeArea(
          top: false,
          child: ListView(
            reverse: reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Community Rules',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.book),
                // onTap: () => showCupertinoModalBottomSheet(
                //     expand: false,
                //     context: context,
                //     builder: ((context) => CommunityCreationModal(
                //           reverse: reverse,
                //         ))),
                onTap: () {
                  Navigator.of(context).pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CommunityRulesPage()));
                },
              ),
              // if (!isJoined!)
              //   ListTile(
              //     title: const Text(
              //       'Community Settings',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     leading: const Icon(Icons.settings),
              //     onTap: () {
              //       Navigator.of(context).pop(context);
              //       Navigator.push(
              //           context,
              //           CupertinoPageRoute(
              //               builder: (context) =>
              //                   const CommunitySettingPage()));
              //     },
              //     // onTap: () => showCupertinoModalBottomSheet(
              //     //     expand: false,
              //     //     context: context,
              //     //     builder: ((context) => CommunityCreationModal(
              //     //           reverse: reverse,
              //     //         ))),
              //   ),
              // ListTile(
              //   title: const Text(
              //     'Leave Community',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   leading: const Icon(Icons.keyboard_return),
              //   onTap: () {
              //     Navigator.pop(context);
              //     _showLeaveCommunityDialog(context);
              //   },
              // onTap: () => showCupertinoModalBottomSheet(
              //     expand: false,
              //     context: context,
              //     builder: ((context) => CommunityListModal(
              //           reverse: reverse,
              //         ))),
              // ),
            ],
          )),
    ));
  }
}

void _showLeaveCommunityDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Leave Community'),
      content: const Text('Are you sure want to leave this community?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
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

class CommunityDiscoverModal extends StatefulWidget {
  const CommunityDiscoverModal(
      {super.key,
      this.reverse = false,
      required this.discoverImage,
      required this.discoverId});
  final bool reverse;
  final String discoverId;
  final String discoverImage;

  @override
  State<CommunityDiscoverModal> createState() => _CommunityDiscoverModalState();
}

class _CommunityDiscoverModalState extends State<CommunityDiscoverModal> {
  bool isDetailFetched = false;
  late User currentUser;
  Map<String, dynamic> communityDetail = {
    'id': '',
    'partner_id': '1',
    'category_id': '1',
    'name': 'Community Default Name',
    'description': 'Community Default Description',
    'privacy': 'public',
    'location': 'Indonesia',
    'since': '2024',
    'sequence': '1',
    'total_member': 'N/A',
    'is_user_joined': false,
    'is_pending_approval': false
  };
  @override
  void initState() {
    super.initState();
    _fetchCommunityDetail();
  }

  void _fetchCommunityDetail() async {
    setState(() {
      isDetailFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      print('discoverid....');
      print(widget.discoverId);
      Response response = await dioClient.get(
          '/community/detail/${widget.discoverId}',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here..');
      print(response);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        setState(() {
          communityDetail = response.data;
          isDetailFetched = false;
        });
        // Successful response, parse the JSON
        print(communityDetail);
        print('end');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('error community detail...');
      print(e);
      setState(() {
        isDetailFetched = false;
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

  void joinCommunity(roomId) async {
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.post('/community/join',
          data: {'communityId': widget.discoverId},
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here..');
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Create Chat Room
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
          if (user != null) {
            print(user.email);
            print(user.uid);
            print(roomId);
            final room = FirebaseChatCore.instance.room(roomId);
            print(room);
            types.Room selectedRoom;
            bool exists = false;
            room.listen((value) {
              print(value.users);
              for (var firebaseUser in value.users) {
                print('comparing...');
                print(firebaseUser.id);
                print(user.uid);
                if (firebaseUser.id == user.uid) {
                  exists = true;
                  break;
                }
              }
              print('am i exist in the list????');
              if (!exists) {
                print('im not exist so trying to add in...');
                value.users.add(types.User(id: user.uid));
                FirebaseChatCore.instance.updateRoom(value);
              }
              print(types.User(id: user.uid));
              print(!value.users.contains(types.User(id: user.uid)));
              if (!value.users.contains(types.User(id: user.uid))) {
                // value.users.add(types.User(id: user.uid));
                // FirebaseChatCore.instance.updateRoom(value);
              }
              print('check user..');
              print(value.users);
            });
            // print('trying to cancel stream');
            // await streamSubscription.cancel();
            // print('finish cancel');
          }
        });

        // Show Notification
        // ignore: use_build_context_synchronously
        toastification.show(
          // ignore: use_build_context_synchronously
          context: context,
          title: const Text("Success"),
          description: Text(
            response.data['message'] ?? 'Please wait a moment...',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          autoCloseDuration: const Duration(seconds: 2),
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          alignment: Alignment.topCenter,
          direction: TextDirection.ltr,
          dragToClose: false,
          showProgressBar: false,
          closeButtonShowType: CloseButtonShowType.none,
          callbacks: ToastificationCallbacks(
              onAutoCompleteCompleted: (toastItem) => {
                    Navigator.pop(context),
                    // _showCommunityCreatedDialog(context, communityName),
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => CommunitiesDetailPage(
                              communityId: widget.discoverId.toString(),
                              communityName: communityDetail['data']?['name'] ??
                                  'Community Default Name',
                              communityImage: widget.discoverImage,
                            )))
                  }),
        );
      } else {
        print('Failed to join community data: ${response.statusCode}');
      }
      EasyLoading.dismiss();
    } on DioException catch (e) {
      print('error community detail...');
      print(e);
      EasyLoading.dismiss();
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
              'Failed to join communities',
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
    return Material(
        child: CupertinoPageScaffold(
      child: SafeArea(
          top: false,
          child: Skeletonizer(
            enabled: isDetailFetched,
            child: isDetailFetched
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration:
                        const BoxDecoration(color: CupertinoColors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Use min size to prevent fullscreen
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 340,
                              height: 200,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 340,
                                    height: 147,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/community_background.png"),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 128,
                                    top: 105,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      width: 84,
                                      height: 84,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 84,
                                            height: 84,
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFFECEFF1),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                          Container(
                                            width: 69,
                                            height: 69,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    widget.discoverImage),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(232),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Default Community Name',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: CupertinoColors.black,
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '66',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: CupertinoColors.black,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  'Members',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: CupertinoColors.black,
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '13',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: CupertinoColors.black,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  'Achievement',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: CupertinoColors.black,
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '2019',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: CupertinoColors.black,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  'Since',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: CupertinoColors.black,
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: const Text(
                            "Devil's Reject Nation is a tight-knit company of motorcycle enthusiasts who share a passion for the open road and a love for are things two-wheeled. We're not your typical riders, we're a bothered and sisterhood of rebels, adventures, and free spirits who to together to embrace the thrill of a trip",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                        // BUTTON JOIN DISINI
                        if (true)
                          CupertinoButton(
                              color: Colors.blue.shade600,
                              child: const Text(
                                'View',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {}),
                      ],
                    ))
                : communityDetail['data'] != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration:
                            const BoxDecoration(color: CupertinoColors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Use min size to prevent fullscreen
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 340,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 340,
                                        height: 147,
                                        decoration: ShapeDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/community_background.png"),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 128,
                                        top: 105,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 6),
                                          width: 84,
                                          height: 84,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 84,
                                                height: 84,
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Color(0xFFECEFF1),
                                                  shape: OvalBorder(),
                                                ),
                                              ),
                                              Container(
                                                width: 69,
                                                height: 69,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        widget.discoverImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            232),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              communityDetail['data']?['name'] ??
                                  'Community Name',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: CupertinoColors.black,
                                  fontFamily: 'Roboto'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      (communityDetail['data'] != null &&
                                              communityDetail['data']
                                                      ['total_member'] !=
                                                  null)
                                          ? communityDetail['data']
                                                  ['total_member']
                                              .toString()
                                          : 'N/A',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                    const Text(
                                      'Members',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      '13',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      'Achievement',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      (communityDetail['data'] != null &&
                                              communityDetail['data']
                                                      ['since'] !=
                                                  null)
                                          ? communityDetail['data']['since']
                                              .toString()
                                          : 'N/A',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                    const Text(
                                      'Since',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Text(
                                (communityDetail['data'] != null &&
                                        communityDetail['data']
                                                ['description'] !=
                                            null)
                                    ? communityDetail['data']['description'] ??
                                        "Default Community Description"
                                    : 'N/A',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                            ),
                            // BUTTON JOIN DISINI

                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Row(
                                mainAxisAlignment: communityDetail['data']
                                            ?['is_user_joined'] ??
                                        false
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.spaceBetween,
                                children: [
                                  // if (communityDetail['data']
                                  //         ?['is_pending_approval'] ??
                                  //     false ||
                                  //         communityDetail['data']?['privacy'] ==
                                  //             'private')
                                  //   Container(
                                  //     width:
                                  //         MediaQuery.of(context).size.width / 2,
                                  //     child: CupertinoButton(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             horizontal: 0, vertical: 12),
                                  //         color: Colors.blue.shade600,
                                  //         onPressed: null,
                                  //         child: const Text(
                                  //           'Pending Approval',
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.w600,
                                  //               color: CupertinoColors.black),
                                  //         )),
                                  //   ),
                                  if (communityDetail['data']
                                          ?['is_user_joined'] ||
                                      communityDetail['data']?['privacy'] ==
                                          'public')
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CupertinoColors.activeBlue),
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust the radius as needed
                                      ),
                                      child: CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 64, vertical: 12),
                                          color: !communityDetail['data']
                                                      ?['is_user_joined'] &&
                                                  !communityDetail['data']
                                                      ?['is_pending_approval']
                                              ? Colors.transparent
                                              : Colors.blue.shade600,
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: !communityDetail['data']
                                                            ?[
                                                            'is_user_joined'] &&
                                                        !communityDetail['data']
                                                            ?[
                                                            'is_pending_approval']
                                                    ? CupertinoColors.activeBlue
                                                    : CupertinoColors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // _showCommunityCreatedDialog(context, communityName),
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        CommunitiesDetailPage(
                                                          communityId: widget
                                                              .discoverId
                                                              .toString(),
                                                          communityName:
                                                              communityDetail[
                                                                          'data']
                                                                      ?[
                                                                      'name'] ??
                                                                  'Community Default Name',
                                                          communityImage: widget
                                                              .discoverImage,
                                                        )));
                                          }),
                                    ),
                                  if (!communityDetail['data']
                                              ?['is_user_joined'] &&
                                          !communityDetail['data']
                                              ?['is_pending_approval'] ||
                                      communityDetail['data']?['privacy'] ==
                                          'private')
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: CupertinoButton(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 64, vertical: 14),
                                            color: Colors.blue.shade600,
                                            child: const Text(
                                              'Join',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            onPressed: () {
                                              EasyLoading.show(
                                                  status: 'loading...',
                                                  maskType: EasyLoadingMaskType
                                                      .black);
                                              joinCommunity(
                                                  communityDetail['data']
                                                      ?['roomId']);
                                            })),
                                ],
                              ),
                            )
                          ],
                        ))
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration:
                            const BoxDecoration(color: CupertinoColors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Use min size to prevent fullscreen
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 340,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 340,
                                        height: 147,
                                        decoration: ShapeDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/community_background.png"),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 128,
                                        top: 105,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 6),
                                          width: 84,
                                          height: 84,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 84,
                                                height: 84,
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Color(0xFFECEFF1),
                                                  shape: OvalBorder(),
                                                ),
                                              ),
                                              Container(
                                                width: 69,
                                                height: 69,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        widget.discoverImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            232),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Community Name',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: CupertinoColors.black,
                                  fontFamily: 'Roboto'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'N/A',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      'Members',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '13',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      'Achievement',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'N/A',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      'Since',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.black,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: const Text(
                                "Default Community Description",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                            ),
                            // BUTTON JOIN DISINI
                          ],
                        )),
          )),
    ));
  }
}

class DiscoverCommunitiesCard extends StatefulWidget {
  const DiscoverCommunitiesCard(
      {super.key,
      required this.communitiesId,
      required this.communitiesImage,
      required this.communitiesName});
  final String communitiesId;
  final String communitiesImage;
  final String communitiesName;

  @override
  State<DiscoverCommunitiesCard> createState() =>
      _DiscoverCommunitiesCardState();
}

class _DiscoverCommunitiesCardState extends State<DiscoverCommunitiesCard> {
  bool isDetailFetched = false;
  Map<String, dynamic> communityDetail = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              builder: (context) => CommunityDiscoverModal(
                    discoverId: widget.communitiesId,
                    discoverImage: widget.communitiesImage != 'null'
                        ? widget.communitiesImage
                        : 'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
                    reverse: false,
                  ));
        },
        child: Container(
          width: 65,
          height: 65,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              border: KonektoBorder.all(color: Colors.grey.shade400),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: const Color(0xffECEFF1)),
          child: Image.network(
            widget.communitiesImage != 'null'
                ? widget.communitiesImage
                : 'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
            height: 55.0,
            width: 55.0,
          ),
        ));
  }
}
