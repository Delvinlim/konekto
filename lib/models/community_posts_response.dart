class CommunityPostsResponse {
  List<CommunityPost>? communityPosts;

  CommunityPostsResponse({this.communityPosts});

  factory CommunityPostsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? communityPostsData = json['data'];
    if (communityPostsData == null) {
      return CommunityPostsResponse(communityPosts: []);
    }

    List<CommunityPost> communityPostsList = communityPostsData
        .map((notificationJson) => CommunityPost.fromJson(notificationJson))
        .toList();

    return CommunityPostsResponse(communityPosts: communityPostsList);
  }
}

class PostResponse {
  CommunityPost? communityPosts;

  PostResponse({this.communityPosts});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    dynamic communityPostsData = json['data'];
    if (communityPostsData == null) {
      return PostResponse(communityPosts: CommunityPost());
    }

    CommunityPost singlePost = CommunityPost.fromJson(communityPostsData);

    return PostResponse(communityPosts: singlePost);
  }
}

class CommunityPost {
  String? id;
  String? partnerId;
  String? communityId;
  String? date;
  String? content;
  String? imageUrl;
  CommunityDetail? communityDetail;
  PartnerDetail? partnerDetail;

  CommunityPost(
      {this.id,
      this.partnerId,
      this.communityId,
      this.date,
      this.content,
      this.imageUrl,
      this.communityDetail,
      this.partnerDetail});

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    print('check model...');
    print(json);
    print(json['data']);
    print(json['partner']);
    return CommunityPost(
      id: json['id']?.toString(),
      partnerId: json['partnerId'].toString(),
      communityId: json['communityId'].toString(),
      date: json['date'].toString(),
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      // communityDetail: json['notification'] as CommunityDetail?
      communityDetail: json['community'] != null
          ? CommunityDetail.fromJson(json['community'] as Map<String, dynamic>)
          : null,
      partnerDetail: json['partner'] != null
          ? PartnerDetail.fromJson(json['partner'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> postdata = {
      'id': id,
      'partnerId': partnerId,
      'communityId': communityId,
      'content': content,
      'imageUrl': imageUrl,
      'communityDetail': communityDetail,
      'partnerDetail': partnerDetail
    };
    return postdata;
  }
}

class CommunityDetail {
  String? id;
  String? name;
  String? imageUrl;

  CommunityDetail({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory CommunityDetail.fromJson(Map<String, dynamic> json) {
    return CommunityDetail(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> detailData = {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
    return detailData;
  }
}

class PartnerDetail {
  String? name;

  PartnerDetail({
    this.name,
  });

  factory PartnerDetail.fromJson(Map<String, dynamic> json) {
    return PartnerDetail(
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> detailData = {
      'name': name,
    };
    return detailData;
  }
}
