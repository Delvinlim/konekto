class CommunityEventsResponse {
  List<CommunityEvent>? events;

  CommunityEventsResponse({this.events});

  factory CommunityEventsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? eventsData = json['data'];
    if (eventsData == null) {
      return CommunityEventsResponse(events: []);
    }

    List<CommunityEvent> eventsList = eventsData
        .map((categoryJson) => CommunityEvent.fromJson(categoryJson))
        .toList();

    return CommunityEventsResponse(events: eventsList);
  }
}

class CommunityEvent {
  String? id;
  String? name;
  String? subName;
  String? imageUrl;
  String? description;
  String? eventType;

  CommunityEvent(
      {this.id,
      this.name,
      this.subName,
      this.imageUrl,
      this.description,
      this.eventType});

  factory CommunityEvent.fromJson(Map<String, dynamic> json) {
    return CommunityEvent(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      subName: json['subName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      eventType: json['eventType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categoryData = {
      'id': id,
      'name': name,
      'subName': subName,
      'imageUrl': imageUrl,
      'description': description,
      'eventType': eventType,
    };
    return categoryData;
  }
}
