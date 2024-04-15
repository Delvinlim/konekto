class PersonalCommunitiesResponse {
  List<KonektoCommunity>? communities;

  PersonalCommunitiesResponse({this.communities});

  factory PersonalCommunitiesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? communitiesData = json['data']['personalCommunities'];
    if (communitiesData == null) {
      return PersonalCommunitiesResponse(communities: []);
    }

    List<KonektoCommunity> categoriesList = communitiesData
        .map((categoryJson) => KonektoCommunity.fromJson(categoryJson))
        .toList();

    return PersonalCommunitiesResponse(communities: categoriesList);
  }
}

class JoinedCommunitiesResponse {
  List<KonektoCommunity>? communities;

  JoinedCommunitiesResponse({this.communities});

  factory JoinedCommunitiesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? communitiesData = json['data']['joinedCommunities'];
    if (communitiesData == null) {
      return JoinedCommunitiesResponse(communities: []);
    }

    List<KonektoCommunity> categoriesList = communitiesData
        .map((categoryJson) => KonektoCommunity.fromJson(categoryJson))
        .toList();

    return JoinedCommunitiesResponse(communities: categoriesList);
  }
}

class KonektoCommunity {
  String? id;
  String? name;
  String? since;

  KonektoCommunity({this.id, this.name, this.since});

  factory KonektoCommunity.fromJson(Map<String, dynamic> json) {
    return KonektoCommunity(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      since: json['since'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> communityData = {
      'id': id,
      'name': name,
      'since': since,
    };
    return communityData;
  }
}
