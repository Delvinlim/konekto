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
    final Map<String, dynamic> notificationData = {
      'id': id,
      'partnerId': partnerId,
      'communityId': communityId,
      'content': content,
      'imageUrl': imageUrl,
      'communityDetail': communityDetail
    };
    return notificationData;
  }
}

class CommunityDetail {
  String? id;
  String? name;

  CommunityDetail({
    this.id,
    this.name,
  });

  factory CommunityDetail.fromJson(Map<String, dynamic> json) {
    return CommunityDetail(
      id: json['id']?.toString(),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> detailData = {
      'id': id,
      'name': name,
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
